-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.06.2021 11:12:11
-- Design Name: 
-- Module Name: FSMCalendar - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSMCalendar is
  Port ( 
  clock : in std_logic;
  CEDebounce : in std_logic;
  reset : in std_logic;
  buttonMoreSync : in std_logic;
  buttonChoiceSync : in std_logic;
  buttonCheckSync : in std_logic;
  checkE : out std_logic;
  dispDDMM : out std_logic;
  EDayCounter : out std_logic;
  EMonthCounter : out std_logic;
  EYearCounter : out std_logic  
    );
    
end FSMCalendar;

architecture Behavioral of FSMCalendar is

type state_t is (wait_modify_day, modify_day, incr_day, wait_modify_month, modify_month, incr_month, wait_modify_year, modify_year, incr_year);
signal state : state_t := wait_modify_day;
  
  begin
  
  fsm_p : process (clock,CEDebounce, reset) is
    begin
    if reset = '1' then
        dispDDMM <= '1';
        checkE <= '0';
        EDayCounter <= '0';
        EMonthCounter <= '0';
        EYearCounter <= '0';
        state <= wait_modify_day;
        
    elsif rising_edge(clock) then
        if CEDebounce = '1' then
            case state is
            
            when wait_modify_day =>
                EDayCounter <= '0';
                EMonthCounter <= '0';
                EYearCounter <= '0';
                dispDDMM <= '1';
                checkE <= '0';
                if buttonChoiceSync = '0' then 
                    state <= modify_day;
                end if;
        
            when modify_day =>
                if buttonCheckSync = '1' then
                    checkE <= '1';
                else
                    checkE <= '0';
                end if;
                EDayCounter <= '0';
                if buttonMoreSync = '1' then 
                    state <= incr_day;
                elsif buttonChoiceSync = '1' then
                    state <= wait_modify_month;
                end if;
        
            when incr_day =>
                checkE <= '0';
                EDayCounter <= '1';
                if buttonMoreSync = '1' then 
                    state <= incr_day;
                elsif buttonMoreSync = '0' then 
                    state <= modify_day;
                end if;
                
             when wait_modify_month =>
                EDayCounter <= '0';
                EmonthCounter <= '0';
                checkE <= '0';
                if buttonChoiceSync = '0' then 
                    state <= modify_month;
                end if;
                
            when modify_month =>
                if buttonCheckSync = '1' then
                    checkE <= '1';
                else
                    checkE <= '0';
                end if;
                EmonthCounter <= '0';
                if buttonMoreSync = '1' then 
                    state <= incr_month;
                elsif buttonChoiceSync = '1' then
                    state <= wait_modify_year;
                end if;
            
            when incr_month =>
                checkE <= '0';
                EmonthCounter <= '1';
                if buttonMoreSync = '1' then 
                    state <= incr_month;
                elsif buttonMoreSync = '0' then 
                    state <= modify_month;
                end if;
                
            when wait_modify_year =>
                dispDDMM <= '0';
                checkE <= '0';
                if buttonChoiceSync = '0' then 
                    state <= modify_year;
                end if;
                
            when modify_year =>
                if buttonCheckSync = '1' then
                    checkE <= '1';
                else
                    checkE <= '0';
                end if;
                EmonthCounter <= '0';
                EyearCounter <= '0';
                if buttonMoreSync = '1' then 
                    state <= incr_year;
                elsif buttonChoiceSync = '1' then
                    state <= wait_modify_day;
                end if;
                
            when incr_year =>
                checkE <= '0';
                EyearCounter <= '1';
                if buttonMoreSync = '1' then 
                    state <= incr_year;
                elsif buttonMoreSync = '0' then 
                    state <= modify_year;
                end if;
            end case; 
        end if;  
    end if;              
end process;
end architecture Behavioral;
                
                 
                
        
        
        
    

