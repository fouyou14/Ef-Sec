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

entity UART_RX_BLOC is
generic (
    g_CLKS_PER_BIT : integer := 651
    );
port(
     CLOCK : in std_logic;
     RX_pin : in std_logic;
	 localisation_rx : out std_logic_vector(3 downto 0);
	 data_rx : out std_logic_vector(3 downto 0);
	 rx_dv : out std_logic
	 );
end UART_RX_BLOC;

architecture Behavioral of UART_RX_BLOC is

component UART_RX is
  generic (
    g_CLKS_PER_BIT : integer := 651
    );
  port (
    i_Clk       : in  std_logic;
    i_RX_Serial : in  std_logic;
    o_RX_DV     : out std_logic;
    o_RX_Byte   : out std_logic_vector(7 downto 0)
    );
end component UART_RX;

component id_code_gen is
port(
done:in std_logic;
byte_i: in std_logic_vector(7 downto 0);
id_o: out std_logic_vector(3 downto 0);
code_o: out std_logic_vector(3 downto 0)
);
end component id_code_gen;

signal Rx_B : std_logic_vector(7 downto 0);
signal DV_Rx : std_logic;

begin

U3: UART_RX generic map (g_CLKS_PER_BIT=>651) 
		  port map (i_Clk => CLOCK,
					i_RX_Serial => RX_pin,
					o_RX_DV => DV_Rx,
					o_RX_Byte => Rx_B
					);

U4: id_code_gen port map (done => DV_Rx,
                            byte_i => Rx_B,
                            id_o => localisation_rx,
                            code_o => data_rx
                            );
rx_dv <=  DV_Rx;

end Behavioral;
