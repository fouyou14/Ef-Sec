----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2021 14:09:13
-- Design Name: 
-- Module Name: testConnected - Behavioral
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

entity testbenchCalendar is
  Port (
  
          
          -- clk and reset
          clk_in          : in  std_logic;
          rstn_in         : in  std_logic;
--          -- push-buttons
--          buttonMore         : in  std_logic;
--          buttonChoice         : in  std_logic;
--          buttonCheck         : in  std_logic;
          
          -- 7-segment display
          disp_seg_o     : out std_logic_vector(7 downto 0);
          disp_an_o      : out std_logic_vector(3 downto 0);
          -- leds
          led_o          : out std_logic_vector(6 downto 0)
   );
end testbenchCalendar;

architecture Behavioral of testbenchCalendar is

component ClockManagement is
	port ( 	
    	clock : in  STD_LOGIC;
		reset : in  STD_LOGIC;
		ceSlow : out STD_LOGIC;
        ceDebounce : out STD_LOGIC;
        ClockEnableDisplay : out STD_LOGIC
    );
	end component;
	
	component Sync is
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
	end component;
	
	component MyMod4 is
	port(
    	clock : in std_logic;
        reset : in std_logic;
        clockEnableDisplay : in std_logic;
        AN : out std_logic_vector (3 downto 0);
        mod4 : out std_logic_vector (1 downto 0)
    );
	end component;
	
	component FSMCalendar is
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
	end component;

    component Counters 
        Port ( 
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           CESlow : in STD_LOGIC;
           EDayCounter : in STD_LOGIC;
           EMonthCounter : in STD_LOGIC;
           EYearCounter : in STD_LOGIC;
           day : out STD_LOGIC_VECTOR (4 downto 0);
           month : out STD_LOGIC_VECTOR (3 downto 0);
           year : out STD_LOGIC_VECTOR (10 downto 0)
        );
    end component; 

	component Transcoder 
        port (
    	dispDDMM : in std_logic;
        day : in std_logic_vector (4 downto 0);
        month : in std_logic_vector (3 downto 0);
        year : in std_logic_vector (10 downto 0);
        disp0 : out std_logic_vector (7 downto 0);
        disp1 : out std_logic_vector (7 downto 0);
        disp2 : out std_logic_vector (7 downto 0);
        disp3 : out std_logic_vector (7 downto 0)
	);
    end component; 
	
    component Mux4to1 
        port(   
                disp0, disp1, disp2, disp3 : in    std_logic_vector(7 downto 0); 
                mod4 : in std_logic_vector(1 downto 0); 
                sevenSeg : out std_logic_vector(7 downto 0) 
    ); 
    end component; 
    
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
    
    -- Signaux des horloges
    signal CESlow : std_logic := '0';
    signal CEDebounce : std_logic := '0';
    signal clockEnableDisplay : std_logic := '0';
    
    --Signaux boutton
    signal buttonMore : std_logic := '0';
    signal buttonChoice : std_logic := '0';
    signal buttonCheck: std_logic := '0';
    signal buttonMoreSync : std_logic;
    signal buttonChoiceSync : std_logic;
    signal buttonCheckSync : std_logic;
    
    --Signaux mod4
    signal AN : std_logic_vector (3 downto 0) := "0000";
    signal mod4 : std_logic_vector (1 downto 0) := "00";
    
    signal checkE : std_logic;
    
    --Signaux pour counters
    signal dispDDMM : std_logic;
    signal EDayCounter : std_logic;
    signal EMonthCounter : std_logic;
    signal EYearCounter : std_logic;
    
    --Signaux pour transcoder
    signal day : std_logic_vector(4 downto 0); 
    signal month : std_logic_vector(3 downto 0); 
    signal year : std_logic_vector(10 downto 0); 

    --Signaux pour Mux4to1
    signal disp0 : std_logic_vector(7 downto 0); 
    signal disp1 : std_logic_vector(7 downto 0); 
    signal disp2 : std_logic_vector(7 downto 0); 
    signal disp3 : std_logic_vector(7 downto 0); 
    signal sevenSeg : std_logic_vector(7 downto 0);
    
    --Signaux pour Check
    signal totalDayNumber : STD_LOGIC_VECTOR(14 downto 0);
    signal ok : std_logic; 
    
    --signal LEDManagement
    signal led : std_logic_vector (6 downto 0) := "0000001";

begin

InstClockManagement : ClockManagement
    port map (
        clock => clkin,
		reset => resetin,
		ceSlow => CESlow,
        ceDebounce => CEDebounce,
        ClockEnableDisplay => clockEnableDisplay
    );

InstSync : Sync
    port map (
        clock => clkin,
        reset => resetin,
        CEDebounce => CEDebounce,
        buttonMore => buttonMore,
        buttonChoice => buttonChoice,
        buttonCheck => buttonCheck,
        buttonMoreSync => buttonMoreSync,
        buttonChoiceSync => buttonChoiceSync,
        buttonCheckSync => buttonCheckSync
    );
    
MyModFourUnderTest : MyMod4
    port map (
    	clock => clkin,
        reset => resetin,
        clockEnableDisplay => clockEnableDisplay,
        AN => AN,
        mod4 => mod4
    );
    
InstFSMCalendar : FSMCalendar
    port map (
        clock => clkin,
        CEDebounce => CEDebounce,
        reset => resetin,
        buttonMoreSync => buttonMoreSync,
        buttonChoiceSync => buttonChoiceSync,
        buttonCheckSync => buttonCheckSync,
        checkE => checkE,
        dispDDMM => dispDDMM,
        EDayCounter => EDayCounter,
        EMonthCounter => EMonthCounter,
        EYearCounter => EYearCounter
    );

InstCounters : Counters
    port map (
        clock => clkin,
        reset => resetin,
        CESlow => CESlow,
        EDayCounter => EDayCounter,
        EMonthCounter => EMonthCounter,
        EYearCounter => EYearCounter,
        day => day,
        month => month,
        year => year
    );

InstTranscoder : Transcoder
    port map( 
        dispDDMM => dispDDMM,
        day => day,
        month => month,
        year => year,
        disp0 => disp0,
        disp1 => disp1,
        disp2 => disp2,
        disp3 => disp3
    );
    
InstMyMux4 : Mux4to1 
    port map ( 
    	disp0 => disp0, 
        disp1 => disp1, 
        disp2 => disp2, 
      	disp3 => disp3, 
      	mod4  => mod4, 
      	sevenSeg => sevenSeg
    );
    
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
--            WAIT FOR 520 ms;
--            resetin <= '1';
--            WAIT FOR 15 ns;
--            resetin <= '0';
            wait;
        end process;
        
   
        
         Mybutton1 : process
      begin
      buttonMore <= '0';
      wait for 490 ms;
      buttonMore <= '1';
      wait for 250 ms;
      buttonMore <= '0';
      wait for 250 ms;
      buttonMore <= '1';
      wait for 200 ms;
      buttonMore <= '0';
      wait; 
      end process;
    
         
 Mybutton2 : process
           begin
           buttonChoice <= '0';
           wait for 200 ms;
           buttonChoice <= '1';
           wait for 200 ms;
           buttonChoice <= '0';
           wait;
           end process;

       
 Mybutton3 : process
           begin
           buttonCheck <= '0';
           wait for 740 ms;
           buttonCheck <= '1';
           wait for 200 ms;
           buttonCheck <= '0';
           wait for 250 ms;
           buttonCheck <= '1';
           wait;
           end process;

disp_an_o <= AN;
disp_seg_o <= not sevenSeg;
led_o <= led;
end Behavioral;
