----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.06.2021 16:28:37
-- Design Name: 
-- Module Name: Sync - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sync is
    port (
    	clock : in std_logic;
        reset : in std_logic;
        CEDebounce : in std_logic;
        buttonMore : in std_logic;
        buttonChoice : in std_logic;
        buttonCheck: in std_logic;
        buttonMoreSync : out std_logic;
        buttonChoiceSync : out std_logic;
        buttonCheckSync : out std_logic
	);
end Sync;

architecture Behavioral of Sync is

    signal More : std_logic ;
    signal Choice : std_logic ;
    signal Check : std_logic ;
    signal MoreB : std_logic ;
    signal ChoiceB : std_logic ;
    signal CheckB : std_logic ;

begin

    MySynch : process( clock, reset, CEDebounce, buttonMore,buttonChoice, buttonCheck) 
    begin 
        if (reset = '1') then
        	More <= '0';
        	Choice <= '0';
        	Check <= '0';
        	-- MoreB <= '0';
        	-- ChoiceB <= '0';
        	-- CheckB <= '0';
        elsif rising_edge(CEDebounce) then
            if (More = '1') then
                More <= '0';
            end if;
            if (Choice = '1') then
                Choice <= '0';
            end if;    
            if (Check = '1') then
                Check <= '0';
            end if;
            if (buttonMore = '1') then
                More <= '1';
            end if;
            if (buttonChoice = '1') then
                Choice <= '1';
            end if;
            if (buttonCheck = '1') then
                Check <= '1';
            end if;
        end if;
    end process;
    buttonMoreSync <= More;
    buttonChoiceSync <= Choice;
    buttonCheckSync <= Check;

end Behavioral;
