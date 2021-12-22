----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2021 12:38:20
-- Design Name: 
-- Module Name: UART_RX_BLOC - Behavioral
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

entity UART_TX_BLOC is
generic (
    g_CLKS_PER_BIT : integer := 651
    );
port(
     CLOCK : in std_logic;
     tx_en : in std_logic;
     localisation_tx : in std_logic_vector(3 downto 0);
	 data_tx : in std_logic_vector(3 downto 0);
	 TX_pin : out std_logic
	 );
end UART_TX_BLOC;

architecture Behavioral of UART_TX_BLOC is

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

component byte_gen is
port(
      en : in std_logic;
      id_i : in std_logic_vector(3 downto 0);
	  code_i : in std_logic_vector(3 downto 0);
	  byte_o : out std_logic_vector(7 downto 0)
	  );
end component byte_gen;

signal Tx_B : std_logic_vector(7 downto 0);

begin


U1: byte_gen port map (en => tx_en,
                       id_i => localisation_tx,
                       code_i => data_tx,
                       byte_o => Tx_B
                       );

U2: UART_TX generic map (g_CLKS_PER_BIT=>651) 
		port map(
		            i_Clk => CLOCK, 
					i_TX_DV => tx_en,
					i_TX_Byte => Tx_B,
					o_TX_Serial => TX_pin, 
					o_TX_Active => open,
					o_TX_Done=> open
					);


end Behavioral;
