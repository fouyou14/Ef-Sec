----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2021 14:46:56
-- Design Name: 
-- Module Name: LEDManagement - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LEDManagement is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           checkE : in STD_LOGIC;
           totalDayNumber : in STD_LOGIC_VECTOR(14 downto 0);
           ok : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(6 downto 0)
     );
end LEDManagement;

architecture Behavioral of LEDManagement is

signal NatTDN, Modulo : natural;

begin



NatTDN <= to_integer(unsigned(totalDayNumber));

Modulo <= NatTDN mod 7;

--led <= "0000000" when reset = '1' else
--        "1111111" when ok = '0' and checkE ='1' else
--        "1000000" when Modulo = 1 and ok = '1' and checkE ='1' else
--        "0100000" when Modulo = 2 and ok = '1' and checkE ='1' else
--        "0010000" when Modulo = 3 and ok = '1' and checkE ='1' else
--        "0001000" when Modulo = 4 and ok = '1' and checkE ='1' else
--        "0000100" when Modulo = 5 and ok = '1' and checkE ='1' else
--        "0000010" when Modulo = 6 and ok = '1' and checkE ='1' else
--        "0000001" when Modulo = 0 and ok = '1' and checkE ='1';
        
MyLed : process(reset, clock)
begin
    if reset = '1' then
        led <= "0000000";
    elsif rising_edge(clock) then
        if(checkE = '1') then
            if(ok = '0') then
                led <= "1111111";                
            else
                case (Modulo) is
                    when 0 => led <= "0000001";
                    when 1 => led <= "1000000";
                    when 2 => led <= "0100000";
                    when 3 => led <= "0010000";
                    when 4 => led <= "0001000";
                    when 5 => led <= "0000100";
                    when 6 => led <= "0000010";
                    when others => led <= "0000000";
                end case;            
            end if;
        end if;
    end if;
end process;

end Behavioral;
