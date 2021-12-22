----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2021 09:45:56
-- Design Name: 
-- Module Name: UART_RX_tb - Behavioral
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

entity UART_RX_tb is
--  Port ( );
end UART_RX_tb;

architecture Behavioral of UART_RX_tb is

component uart_rx is
    port (
      i_clk       : in  std_logic;
      i_rx_serial : in  std_logic;
      o_rx_dv     : out std_logic;
      o_rx_byte   : out std_logic_vector(7 downto 0)
      );
  end component uart_rx;

    signal clkin : std_logic;
    signal serial : std_logic;
    signal DV_out : std_logic;
    signal byte_out : std_logic_vector(7 downto 0);

begin

    MyRX : uart_rx
    port map (
        i_clk => clkin,
        i_rx_serial => serial,
        o_rx_dv => DV_out,
        o_rx_byte => byte_out
        );
        
    MyClkProc : process
    begin
        clkin <= '0';
        wait for 80 ns;
        clkin <= '1';
        wait for 80 ns;
    end process;
    
    MyRXProc : process
    begin
        serial <= '1';
        wait for 104.16 us;
        serial <= '0';
        wait for 104.16 us;
        serial <= '0';
        wait for 104.16 us;
        serial <= '0';
        wait for 104.16 us;
        serial <= '1';
        wait for 104.16 us;
        serial <= '0';
        wait for 104.16 us;
        serial <= '0';
        wait for 104.16 us;
        serial <= '0';
        wait for 104.16 us;
        serial <= '1';
        wait for 104.16 us;
        serial <= '1';
        wait for 104.16 us;
        serial <= '1';
        wait;
    end process;


end Behavioral;
