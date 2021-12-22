library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity uart_tb is
end uart_tb;
 
architecture behave of uart_tb is
 
  component uart_scom is
      generic (
            g_CLKS_PER_BIT : integer := 651
      );
      port (
      clock      : in  std_logic;
      RX_pin    : in  std_logic;
      SW_pins   : in  std_logic_vector(7 downto 0);
      TX_pin : out std_logic;
      ID_pins : out std_logic_vector(3 downto 0);
      CODE_pins : out std_logic_vector(3 downto 0)
      );
  end component uart_scom;
 
   
  signal i_clkIN     : std_logic := '0';
  signal i_RX_pinIN    : std_logic := '0';
  signal i_SW_pinsIN   : std_logic_vector(7 downto 0) := (others => '0');
  
  signal o_TX_pinOUT     : std_logic := '0';
  signal o_ID_pinOUT    : std_logic_vector(3 downto 0) := (others => '0');
  signal o_CODE_pinOUT   : std_logic_vector(3 downto 0) := (others => '0');

begin

    MyUart_Scom : Uart_Scom
    port map (
        clock => i_clkIN,
        RX_pin => i_RX_pinIN,
        SW_pins => i_SW_pinsIN,
        TX_pin => o_TX_pinOUT,
        ID_pins => o_ID_pinOUT,
        CODE_pins => o_CODE_pinOUT
        );
        

    MyClkProc : process
    begin
        i_clkIN <= '0';
        wait for 5 ns;
        i_clkIN <= '1';
        wait for 5 ns;
    end process;
    
    MyRXProc : process
    begin
        i_RX_pinIN <= '1';
        wait for 104.16 us;
        i_RX_pinIN <= '0';
        wait for 104.16 us;
        i_RX_pinIN <= '0';
        wait for 104.16 us;
        i_RX_pinIN <= '1';
        wait for 104.16 us;
        i_RX_pinIN <= '0';
        wait for 104.16 us;
        i_RX_pinIN <= '0';
        wait for 104.16 us;
        i_RX_pinIN <= '0';
        wait for 104.16 us;
        i_RX_pinIN <= '1';
        wait for 104.16 us;
        i_RX_pinIN <= '1';
        wait for 104.16 us;
        i_RX_pinIN <= '1';
        wait for 104.16 us;
        i_RX_pinIN <= '1';
        wait;
    end process;
    
    MySWProc : process
    begin
        i_SW_pinsIN <= "10100011";
        WAIT;
    end process;  
end behave;