
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench_fulldesign is
end testbench_fulldesign;

architecture Behavioral of testbench_fulldesign is

component fullDesign is
    Port ( 
    clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    -- boutons
    i_buttonMore         : in  std_logic;
    i_buttonChoice         : in  std_logic;
    i_buttonCheck         : in  std_logic;
    -- sw 0 -> reset ; sw 1 -> tram ok ou incorrecte ; sw 2 -> simul mcu ou reel mcu ; sw 3 -> mode local ou uart
    sw : in std_logic_vector (3 downto 0);
    -- uart
    uart_RX: in std_logic_vector (7 downto 0);
    uart_TX: out STD_LOGIC_VECTOR (7 downto 0);
    Test_uart_RX: in STD_LOGIC_VECTOR (7 downto 0);
    Test_uart_TX: out STD_LOGIC_VECTOR (7 downto 0);
    -- sorties 
    led_f : out std_logic_vector(6 downto 0);
    seg_f : out std_logic_vector(7 downto 0);
    an_f  : out std_logic_vector(3 downto 0)
           );
end component;

signal clksig : std_logic := '0';
signal resetsig : std_logic := '0';
-- boutons
signal buttonMoresig : std_logic;
signal buttonChoicesig : std_logic;
signal buttonChecksig : std_logic;
-- switch pour mode ; trame etc
signal swsig : std_logic_vector (3 downto 0) := "1000";
-- UART
signal uart_RXsig : STD_LOGIC_VECTOR (7 downto 0);
signal uart_TXsig: STD_LOGIC_VECTOR (7 downto 0);
signal Test_uart_RXsig: STD_LOGIC_VECTOR (7 downto 0);
signal Test_uart_TXsig: STD_LOGIC_VECTOR (7 downto 0);

signal led_fsig : std_logic_vector(6 downto 0);
signal seg_fsig : std_logic_vector(7 downto 0);
signal an_fsig  : std_logic_vector(3 downto 0);

begin

partie_1 : fullDesign
    port map (
    clock =>clksig,
    reset =>resetsig,
    i_buttonMore =>buttonMoresig,
    i_buttonChoice =>buttonChoicesig,
    i_buttonCheck =>buttonChecksig,
    sw =>swsig,
    uart_RX =>uart_RXsig,
    uart_TX =>uart_TXsig,
    Test_uart_RX =>Test_uart_RXsig,
    Test_uart_TX =>Test_uart_TXsig,
    led_f => led_fsig,
    seg_f => seg_fsig,
    an_f => an_fsig
    );


    -- Description des évolutions des signaux d'entrées (stimuli)
    	-- Description de l'évolution de l'horloge clkin
    	MyclkProc : process
        begin
        	clksig <= '0';
            WAIT FOR 5 ns;
            clksig <= '1';
            WAIT FOR 5 ns;
        end process;
        
        -- Description de l'évolution de l'entrée resetin
        MyResetProc : process
        begin
        	resetsig <= '1';
        	wait for 15 ns;
        	resetsig <= '0';
--            WAIT FOR 520 ms;
--            resetin <= '1';
--            WAIT FOR 15 ns;
--            resetin <= '0';
            wait;
        end process;
        
        MymodeProc : process
        begin 
            swsig <= "1000";
            wait; -- for 5 ms;
            --swsig <= "1000";
            --wait;
        end process;
        
         Mybutton1 : process
      begin
      buttonMoresig <= '0';
      wait for 240 ms;
      buttonMoresig <= '0';
      wait for 20 ms;
      buttonMoresig <= '0';
      wait for 230 ms;
      buttonMoresig <= '1';
      wait for 20 ms;
      buttonMoresig <= '0';
      wait for 230 ms;
      buttonMoresig <= '1';
      wait for 20 ms;
      buttonMoresig <= '0';

      wait; 
      end process;
    
         
 Mybutton2 : process
           begin
           buttonChoicesig <= '0';
           wait for 740 ms;
           buttonChoicesig <= '0';
           wait for 20 ms;
           buttonChoicesig <= '0';
           wait;
           end process;

       
 Mybutton3 : process
           begin
           buttonChecksig <= '0';
           wait for 950 ms;
           buttonChecksig <= '1';
           wait for 70 ms;
           buttonChecksig <= '0';
           wait for 50 ms;
           buttonChecksig <= '0';
           wait for 40 ms;
           buttonChecksig <= '0';
           wait;
           end process;



end Behavioral;
