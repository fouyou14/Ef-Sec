library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity checkDate_tb is
end checkDate_tb;

architecture Behavioral of checkDate_tb is

    component check_date_mcu 
       Port ( 
        JJMMAAAADCCCC : in std_logic_vector (51 downto 0);
        clock : in std_logic;
        check_Enable  : in std_logic;
        reset : in std_logic;
        Res_Enable : out std_logic;
        check_o : out std_logic
        );
    end component; 
    
signal i_date : std_logic_vector (51 downto 0) := (others => '0');
signal i_clk : std_logic := '0';
signal i_clkEnable  : std_logic := '0';
signal i_reset : std_logic := '0';
signal o_res : std_logic := '0';
signal o_check : std_logic := '0';

begin

    MycheckDate : check_date_mcu
    port map (
        JJMMAAAADCCCC => i_date,
        clock => i_clk,
        check_Enable => i_clkEnable,
        reset => i_reset,
        Res_Enable => o_res,
        check_o => o_check
        );
        
    MyClkProc : process
    begin
        i_clk <= '0';
        wait for 5 ns;
        i_clk <= '1';
        wait for 5 ns;
    end process;
    
    MyDateProc : process
    begin
        i_date <= "0000000000000000000000000000000000000000000000000000";
        wait for 50 ns;
        i_date <= "0010011000000110000110010110010101101000000110000001"; 
        i_clkEnable <= '1';
       -- wait for 20 ns;
        -- i_clkEnable <='0';
        wait;
    end process;
    
    MyresetProc : process
    begin
        i_reset <= '1';
        wait for 5 ns;
        i_reset <= '0';
        wait;
    end process;
end Behavioral;
