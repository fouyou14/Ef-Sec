
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbenchCalendar is
  Port (
 
--       
          -- leds
          led_o          : out std_logic_vector(6 downto 0)
   );
end testbenchCalendar;

architecture Behavioral of testbenchCalendar is

    component Check 
       Port (
            day : in STD_LOGIC_VECTOR (4 downto 0);
            month : in STD_LOGIC_VECTOR (3 downto 0);
            year : in STD_LOGIC_VECTOR (10 downto 0);
            totalDayNumber : out STD_LOGIC_VECTOR(14 downto 0);
            ok : out std_logic);
    end component; 

    component LEDManagement
         Port (
            clock : in std_logic;
            reset : in std_logic;
            checkE : in std_logic;
            totalDayNumber : in std_logic_vector (14 downto 0);
            ok : in std_logic;
            led : out std_logic_vector (6 downto 0)
         );
    end component;
    
	signal clkin : std_logic := '0';
    signal resetin : std_logic := '0';

  
    signal checkE : std_logic := '1';
    
    --Signaux pour transcoder
    signal day : std_logic_vector(4 downto 0) := "00001"; 
    signal month : std_logic_vector(3 downto 0) := "0001"; 
    signal year : std_logic_vector(10 downto 0) := "11110011110"; 
    
    --Signaux pour Check
    signal totalDayNumber : STD_LOGIC_VECTOR(14 downto 0) := "000000000000000";
    signal ok : std_logic := '1'; 
    
    --signal LEDManagement
    signal led : std_logic_vector (6 downto 0) := "0000001";

begin

InstCheck : Check 
    Port map ( 
        day => day,
        month => month,
        year => year,
        totalDayNumber => totalDayNumber,
        ok => ok
     );

InstLEDManagement : LEDManagement
    Port map (
        clock => clkin,
        reset => resetin,
        checkE => checkE,
        totalDayNumber => totalDayNumber,
        ok => ok,
        led => led
    );
    
    -- Description des évolutions des signaux d'entrées (stimuli)
    	-- Description de l'évolution de l'horloge clkin
    	MyclkProc : process
        begin
        	clkin <= '0';
            WAIT FOR 5 ns;
            clkin <= '1';
            WAIT FOR 5 ns;
        end process;
        
        -- Description de l'évolution de l'entrée resetin
        MyResetProc : process
        begin
        	resetin <= '1';
        	wait for 15 ns;
        	resetin <= '0';
            WAIT FOR 350 ms;
            resetin <= '1';
            WAIT FOR 15 ns;
            resetin <= '0';
            wait;
        end process;
        
        MydateProc : process
        begin     	
            WAIT FOR 50 ms;
            day <= day + 6;
            WAIT FOR 50 ms;
            month <= month + 1;
            WAIT FOR 50 ms;
            year <= year + 1;
            WAIT FOR 50 ms;
            day <= "11110";
            WAIT FOR 50 ms;
            day <= "10011";
            WAIT;
        end process;
        
led_o <= led;
end Behavioral;
