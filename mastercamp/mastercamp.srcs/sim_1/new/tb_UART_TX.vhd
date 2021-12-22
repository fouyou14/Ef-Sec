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

entity tb_UART_TX is
--  Port ( );
end tb_UART_TX;

architecture Behavioral of tb_UART_TX is

component UART_TX is
    generic (
    g_CLKS_PER_BIT : integer := 651
    );
  port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
  end component UART_TX;

    signal clkin : std_logic;
    signal serial : std_logic;
    signal DV_in : std_logic;
    signal byte_in : std_logic_vector(7 downto 0);
    signal active_out : std_logic;
    signal done_out : std_logic;

begin

    MyTX : UART_TX
    port map (
        i_Clk => clkin,
    i_TX_DV  => DV_in,
    i_TX_Byte  => byte_in,
    o_TX_Active => active_out,
    o_TX_Serial  => serial,
    o_TX_Done  => done_out
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
        byte_in <= "11110001";
        DV_in <= '1';
        wait;
    end process;


end Behavioral;
