----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.06.2021 21:43:31
-- Design Name: 
-- Module Name: FullDesign - Behavioral
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

-- les entrées et sorties ne sont pas les bonnes. juste pour la forme ici.
entity FullDesign is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           -- boutons
           i_buttonMore         : in  std_logic;
           i_buttonChoice         : in  std_logic;
           i_buttonCheck         : in  std_logic;
           -- sw 0 -> reset ; sw 1 -> tram ok ou incorrecte ; sw 2 -> simul mcu ou reel mcu ; sw 3 -> mode local ou uart
           sw : in std_logic_vector (3 downto 0);
           -- uart
           uart_RX : in STD_LOGIC;
           uart_TX: out STD_LOGIC;
           Test_uart_RX: in STD_LOGIC;
           Test_uart_TX: out STD_LOGIC;
           
          -- sorties 
           led_f : out std_logic_vector(7 downto 0);
           seg_f : out std_logic_vector(7 downto 0);
           an_f  : out std_logic_vector(3 downto 0)
           );
end FullDesign;

architecture Behavioral of FullDesign is

component design is
    Port (
         
          -- clk and reset
          clk_in          : in  std_logic;
          rstn_in         : in  std_logic;
          -- push-buttons
          buttonMore         : in  std_logic;
          buttonChoice         : in  std_logic;
          buttonCheck         : in  std_logic;
          -- 7-segment display
          disp_seg_o     : out std_logic_vector(7 downto 0);
          disp_an_o      : out std_logic_vector(3 downto 0);
          -- leds
          led_o          : out std_logic_vector(6 downto 0)
          
     );
end component;

component design_Partie_2 is
generic (
    g_CLKS_PER_BIT : integer := 651
    );
port(
    CLOCK : in std_logic;
    RESET : in std_logic;
    SWITCH : in std_logic_vector(3 downto 0);
    
    i_UART_RX : in std_logic;
    o_UART_TX : out std_logic;
    
    i_TEST_UART_RX : in std_logic;
    o_TEST_UART_TX : out std_logic;
    
    CHECK_Res : out std_logic;
    
    
    LEDTEST : out std_logic_vector(7 downto 0);
    
    SevenSeg : out std_logic_vector(7 downto 0)

	 );
end component;

signal i_uart_rx, o_uart_tx, i_test_uart_rx, o_test_uart_tx, check_res : std_logic;


signal LED1 : std_logic_vector(6 downto 0);
signal LED2 : std_logic_vector(7 downto 0);
signal AN_o : std_logic_vector(3 downto 0);
signal sevenseg1 : std_logic_vector(7 downto 0);
signal sevenseg2 : std_logic_vector(7 downto 0);

begin
instDesignPart1 : design
    port map (
          -- clk and reset
          clk_in => clock,
          rstn_in =>reset,
          -- push-buttons
          buttonMore => i_buttonMore,
          buttonChoice => i_buttonChoice,
          buttonCheck => i_buttonCheck,
                    
          -- 7-segment display
          disp_seg_o => sevenseg1,
          disp_an_o => AN_o,
          -- leds
          led_o => LED1
     );
     
InstDesignPart2 : design_Partie_2
generic map(
    g_CLKS_PER_BIT => 651
    )
port map(
    CLOCK  => clock,
    RESET  => reset,
    SWITCH  => sw,
    
    i_UART_RX   => uart_RX,
    o_UART_TX   => uart_TX,
    
    i_TEST_UART_RX   => Test_uart_RX,
    o_TEST_UART_TX   => Test_uart_TX,
    
    CHECK_Res   => check_res,
    LEDTEST => LED2,
    SevenSeg => sevenseg2

	 );

process (sw(3))
begin
        an_f <= AN_o;
    if sw(3) ='1' then
        led_f <= "0"&LED1;
        seg_f <= sevenseg1;
    else 
         --led_f <= check_res & "0000000";
         led_f <= LED2;
         seg_f <= sevenseg2;
    end if;
end process;


end Behavioral;
