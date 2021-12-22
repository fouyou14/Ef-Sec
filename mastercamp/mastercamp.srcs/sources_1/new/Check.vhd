----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.06.2021 14:25:20
-- Design Name: 
-- Module Name: Check - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Check is
  Port (
        day : in STD_LOGIC_VECTOR (4 downto 0);
        month : in STD_LOGIC_VECTOR (3 downto 0);
        year : in STD_LOGIC_VECTOR (10 downto 0);
        totalDayNumber : out STD_LOGIC_VECTOR(14 downto 0);
        ok : out std_logic
   );
end Check;

architecture Behavioral of Check is

signal numbertotalday : integer := 0;
signal myok : std_logic := '1';

signal myday : unsigned (4 downto 0);
signal mymonth : unsigned (3 downto 0);
signal myyear : unsigned (10 downto 0);

signal nbbissextile : integer;

signal numberyear : integer;
signal totalYearDay, totalMonthDay : integer;

signal currently_bissextile : std_logic;


begin

myyear <= unsigned(year);
mymonth <= unsigned(month);
myday <= unsigned(day);

Process(myyear)
begin
    numberyear <= to_integer(myyear) - 1950;
end process;

Process(numberyear)
begin
    if(numberyear <= 2) then
        nbbissextile <= 0;
    elsif(numberyear <= 6) then
        nbbissextile <= 1;
    elsif(numberyear <= 10) then
        nbbissextile <= 2;
    elsif(numberyear <= 14) then
        nbbissextile <= 3;
    elsif(numberyear <= 18) then
        nbbissextile <= 4;
    elsif(numberyear <= 22) then
        nbbissextile <= 5;
    elsif(numberyear <= 26) then
        nbbissextile <= 6;
    elsif(numberyear <= 30) then
        nbbissextile <= 7;
    elsif(numberyear <= 34) then
        nbbissextile <= 8;
    elsif(numberyear <= 38) then
        nbbissextile <= 9;
    elsif(numberyear <= 42) then
        nbbissextile <= 10;
    elsif(numberyear <= 46) then
        nbbissextile <= 11;
    else
        nbbissextile <= 12;
    end if;
    
    if((numberyear = 2) or (numberyear = 6) or (numberyear = 10) or (numberyear = 14) or (numberyear = 18) or (numberyear = 22) or (numberyear = 26) or (numberyear = 30) or (numberyear = 34) or (numberyear = 38) or (numberyear = 42) or (numberyear = 46)) then
        currently_bissextile <= '1';
    else
        currently_bissextile <= '0';
    end if;    
end process;

MytotalYearDayProcess : process(nbbissextile,numberyear)
begin
    totalYearDay <= (numberyear*365) + nbbissextile;
end process;

MytotalMonthDayProcess : process(mymonth)
begin
         case (mymonth) is
                when "0001" => totalMonthDay <= 0;
                when "0010" => totalMonthDay <=  31;
                when "0011" => totalMonthDay <= 59;
                when "0100" => totalMonthDay <= 90;
                when "0101" => totalMonthDay <= 120;
                when "0110" => totalMonthDay <= 151;
                when "0111" => totalMonthDay <= 181;
                when "1000" => totalMonthDay <= 212;
                when "1001" => totalMonthDay <= 243;
                when "1010" => totalMonthDay <= 273;
                when "1011" => totalMonthDay <= 304;
                when "1100" => totalMonthDay <= 334;
                when others => totalMonthDay <= 0;
            end case;
end process;

MytotalDayProcess : process(totalMonthDay,totalYearDay,myday)
begin
    if(myok = '1') then
        if(currently_bissextile = '1' and mymonth > "0010") then
            numbertotalday <= totalMonthDay + totalYearday + to_integer(myday) - 1 + 1;
        else    
            numbertotalday <= totalMonthDay + totalYearday + to_integer(myday) - 1;
        end if;
    end if;
end process;

MytranscProc : process( myday, mymonth, currently_bissextile)
    begin
--        if(myyear >= "11110011110" and myyear <= "11111001111") then
--            if (month <= "1100" and month /= "0000") then
--                if (day <= "11100" and day /= "00000")then
--                    myok <= '1';
--                elsif (day <= "11110" and month /= "0010" and day /= "00000") then
--                    myok <= '1';
--                elsif (day <= "11111"  and day /= "00000" and (month = "0001" or month = "0011" or month = "0101" or month = "0111" 
--                        or month = "1000" or month ="1010" or month ="1100")) then
--                     myok <= '1';
--                elsif (day <= "11101"  and day /= "00000" and (year = "11110100000" or year = "11110100100" or year = "11110101000"
--                     or year = "11110101100" or year = "11110110000" or year = "11110110100" or year = "11110111000"
--                      or year = "11110111100" or year = "11111000000" or year = "11111000100" or year = "11111001000" or year = "11111001100")) then
--                      myok <= '1';
--                else
--                    myok <='0';
--                end if;
--           else
--                myok <= '0';
--           end if;
--        else
--            myok <= '0';
--        end if;

        
        if myday = 29 and currently_bissextile = '0' and mymonth = 2 then
            myok <= '0';
        elsif myday = 30 and mymonth = 2 then
            myok <= '0';
        elsif myday = 31 and (mymonth = 2 or mymonth = 4 or mymonth = 6 or mymonth = 9 or mymonth = 11) then
            myok <= '0';
        else
            myok <= '1';
        end if;
    end process;

ok <= myok;
totalDayNumber <= std_logic_vector(to_unsigned(numbertotalday,totalDayNumber'length));

end Behavioral;
