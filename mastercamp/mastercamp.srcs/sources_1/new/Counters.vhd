----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2021 12:29:36
-- Design Name: 
-- Module Name: Counters - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counters is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           CESlow : in STD_LOGIC;
           EDayCounter : in STD_LOGIC;
           EMonthCounter : in STD_LOGIC;
           EYearCounter : in STD_LOGIC;
           day : out STD_LOGIC_VECTOR (4 downto 0);
           month : out STD_LOGIC_VECTOR (3 downto 0);
           year : out STD_LOGIC_VECTOR (10 downto 0));
end Counters;

architecture Behavioral of Counters is

    signal myday : std_logic_vector(4 downto 0) := "00001"; 
    signal mymonth : std_logic_vector(3 downto 0) := "0001"; 
    signal myyear : std_logic_vector(10 downto 0) := "11110011110"; 
begin

counter : process(clock,reset,CESlow,EDayCounter,EMonthCounter,EYearCounter)
begin
    if reset = '1' then
    
        myday <= "00001";
        mymonth <= "0001";
        myyear <= "11110011110";
    
    elsif rising_edge(clock) then
        if (CESlow = '1') then
            if (EDayCounter = '1') then
                
                if (myday = "11111") then
                    myday <= "00001";
                else
                    myday <= myday + 1;
                end if;
                
            elsif (EMonthCounter = '1') then
            
                if (mymonth = "1100") then
                    mymonth <= "0001";
                else
                    mymonth <= mymonth + 1;
                end if;
                
            elsif (EYearCounter = '1') then
            
                if (myyear = "11111001111") then
                    myyear <= "11110011110";
                else
                    myyear <= myyear + 1;
                end if;
            
            end if;
        end if;
    
    end if;

end process;

day <= myday;
month <= mymonth;
year <= myyear;

end Behavioral;
