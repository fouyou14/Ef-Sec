----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.06.2021 16:31:05
-- Design Name: 
-- Module Name: ClockManagement - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockManagement is
    port ( 	
    	clock : in  STD_LOGIC;
		reset : in  STD_LOGIC;
		ceSlow : out STD_LOGIC;
        ceDebounce : out STD_LOGIC;
        ClockEnableDisplay : out STD_LOGIC
    );
end ClockManagement;

architecture Behavioral of ClockManagement is

    -- Constantes fournissant les valeurs limites des compteurs pour la division d'horloge --
	constant MyValCpt200Hz : STD_LOGIC_VECTOR (18 downto 0) := "1111010000100011111";	-- décimal : 499 999
	constant MyValCpt4Hz : STD_LOGIC_VECTOR (24 downto 0) := "1011111010111100000111111";	-- décimal : 24 999 999

	-- Signaux de compteurs pour les divisions d'horloges --
	signal MyCpt200Hz : STD_LOGIC_VECTOR (18 downto 0) := "0000000000000000000";
	signal MyCeDeb200Hz : STD_LOGIC := '1';
	
	signal MyCpt4Hz : STD_LOGIC_VECTOR (24 downto 0) := "0000000000000000000000000";
	signal MyceSlow4Hz : STD_LOGIC := '1';

begin
	
	
	
	-- Process permettant de diviser l'horloge de 100 Mhz à 4 Hz --
	MyClk4Hz_process : process (clock, reset)
	begin
		if (reset = '1') then
        	MyCpt4hz <= "0000000000000000000000000";
        elsif rising_edge(clock) then
        	if MyCpt4Hz = MyValCpt4Hz then
            	MyCpt4Hz <= "0000000000000000000000000";
            else
            	MyCpt4Hz <= MyCpt4Hz + 1;
            end if;
        end if;
    end process;
    
    MyceSlow4Hz <= '1' when MyCpt4Hz = "0000000000000000000000000" else '0';
 
    ceSlow <= MyceSlow4Hz;
	
	
	MyClk200Hz_process : process (clock, reset)
	begin
		if (reset = '1') then
        	MyCpt200Hz <= "0000000000000000000";
        elsif rising_edge(clock) then
        	if MyCpt200Hz = MyValCpt200Hz then
            	MyCpt200Hz <= "0000000000000000000";
            	MyCeDeb200Hz <= '1';
            else
            	MyCpt200Hz <= MyCpt200Hz + 1;
                MyCeDeb200Hz <= '0';
            end if;
        end if;
        --MyClk2Hz <= '1' when MyCpt2Hz = "00000000" else '0';
        -- MyClk2Hz <= '1' when MyCpt2Hz <= (others => '0'); -- Meme syntaxe
    end process;
	
    --MyCeDeb200Hz <= '1' when MyCpt200Hz = "0000000000000000000" else '0';
    ClockEnableDisplay <= MyCeDeb200Hz;
    ceDebounce <= MyCeDeb200Hz;

end Behavioral;
