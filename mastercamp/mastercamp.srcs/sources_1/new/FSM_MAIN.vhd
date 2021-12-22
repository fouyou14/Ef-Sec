----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2021 13:21:02
-- Design Name: 
-- Module Name: FSM_MAIN - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_MAIN is
 
  Port (
    i_reset : in std_logic;
    i_clock : in std_logic;
    --I/O to Check_Date_MCU
    Res_Enable_Date : in std_logic;
    Res_Date : in std_logic;
    CheckE_Date : out std_logic;
    Reset_Date : out std_logic;
    
    --I/O to Check_Code_MCU
    Res_Enable_Code : in std_logic;
    Res_Code : in std_logic;
    CheckE_Code : out std_logic;
    Reset_Code : out std_logic;
        
    i_RX_Localisation : in  std_logic_vector(3 downto 0);
    i_RX_Data : in std_logic_vector(3 downto 0);
    i_RX_DV : in std_logic;
    
    o_TX_Localisation     : out  std_logic_vector(3 downto 0);
    o_TX_Data   : out std_logic_vector(3 downto 0);
    o_TX_en : out std_logic;
    
    o_Data : out std_logic_vector(51 downto 0);
    
    CHECK_RES : out std_logic
   );
end FSM_MAIN;

architecture Behavioral of FSM_MAIN is

type state_t is (s_Start_Trame, s_Read_Trame, s_Stop_Trame);
signal state : state_t := s_Start_Trame;

signal cpt : integer range 0 to 250 := 0;
begin


fsm : process(i_reset, i_clock)
    variable localisation : integer := 0;
    --variable boundary_max : integer := 0;
    --variable boundary_min : integer := 0;
begin

    if i_reset = '1' then
    
        o_Data <= (others => '0');
        CheckE_Date <= '0';
        Reset_Date <= '1';
        Reset_Code <= '1';
       
       cpt <= 0;
       
        state <= s_Start_Trame;
        
    elsif(rising_edge(i_clock)) then
    
        case state is
        
            when s_Start_Trame =>
                
                o_Data <= (others => '0');
                CheckE_Date <= '0';
                Reset_Date <= '1';
                Reset_Code <= '1';
                
                cpt <= 0;
                
                if(i_RX_Localisation = "1101") then
                    state <= s_Start_Trame;
                else 
                    state <= s_Read_Trame;
                end if;   
                
        
            when s_Read_Trame =>
            
                if i_RX_DV = '1' then
                    if(i_RX_Localisation = "1101") then --i_RX = D0h reset
                        state <= s_Start_Trame;
                    else
                        Reset_Date <= '0';
                        Reset_Code <= '0';
                        if(i_RX_Localisation = "1110") then  --i_RX = XEh validate
                            state <= s_Stop_Trame;
                        else
                            localisation := to_integer(unsigned(i_RX_Localisation));
                            if(localisation < 13) then
--                                boundary_max := 51 - (4*localisation);
--                                boundary_min := 48 - (4*localisation);
                                o_Data( (51 - (4*localisation)) downto (48 - (4*localisation))) <= i_RX_Data;
                            end if;
        --                    if(to_integer(unsigned(i_RX_Byte(7 downto 4))) < 13) then
                                
        --                        o_Data( (51 - (4*to_integer(unsigned(i_RX_Byte(7 downto 4)))) )downto (48 - (4*to_integer(unsigned(i_RX_Byte(7 downto 4))))) ) <= i_RX_Byte(3 downto 0);
        --                    end if;
                        end if;
                        
                    end if;
               end if;
                
                                       
            when s_Stop_Trame =>
                CheckE_Date <= '1';
                
                if cpt = 250 then
                    state <= s_Start_Trame;
                else 
                    cpt <= cpt + 1;
                end if;
                
--                if i_RX_DV = '1' then
--                    if(i_RX_Localisation = "1101") then --i_RX = D0h reset
--                        state <= s_Start_Trame;
--                    end if;
--                end if;
                         
                            
        end case;
    
    end if;
end process;

LED : process(Res_Enable_Date,Res_Date,Res_Enable_Code,Res_Code,cpt)
begin
    if( Res_Enable_Date = '1') then     --result date enable
        
        if (Res_Date = '1') then        --date valid
            if(Res_Enable_Code = '1') then  --result code enable
                if(Res_Code = '1') then     --code valid
                    CHECK_RES <= '1';
                    o_TX_Localisation <= "1111";
                    o_TX_Data <= "0001";    --OK to MCU
                    o_TX_en <= '1';              
                else
                    CHECK_RES <= '0';
                    o_TX_Localisation <= "1111";
                    o_TX_Data <= "0000";    --KO to MCU
                    o_TX_en <= '1';     
                end if;
            else
                CHECK_RES <= '0';
                o_TX_Localisation <= "0000";
                o_TX_Data <= "0000";
                o_TX_en <= '0';     
            end if;
        else
            CHECK_RES <= '0';
            o_TX_Localisation <= "1111";
            o_TX_Data <= "0000";    --KO to MCU
            o_TX_en <= '1';
        end if;
    else
        CHECK_RES <= '0';
        o_TX_Localisation <= "0000";
        o_TX_Data <= "0000";
        o_TX_en <= '0';
    end if;
    
end process;

Check_Code_Enable : process(Res_Enable_Date,Res_Date)
begin
        if(Res_Enable_Date = '1' and Res_Date = '1') then
            CheckE_Code <= '1';
        else 
            CheckE_Code <= '0';
        end if;
end process;
 

end Behavioral;
