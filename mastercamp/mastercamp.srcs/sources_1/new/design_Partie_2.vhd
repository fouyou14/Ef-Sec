----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2021 11:35:05
-- Design Name: 
-- Module Name: design_Partie_2 - Behavioral
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


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity design_Partie_2 is
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
end design_Partie_2;

architecture Behavioral of design_Partie_2 is

component UART_RX_BLOC is
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
end component;

component UART_TX_BLOC is
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
end component;

component freq_div is
port(   
    clkin:in std_logic;
	clkout:out std_logic
	);
end component freq_div;

component FSM_MAIN
port (
    i_reset : in std_logic;
    i_clock : in std_logic;
    Res_Enable_Date : in std_logic;
    Res_Date : in std_logic;
    CheckE_Date : out std_logic;
    Reset_Date : out std_logic;
    Res_Enable_Code : in std_logic;
    Res_Code : in std_logic;
    CheckE_Code : out std_logic;
    Reset_Code : out std_logic;
    i_RX_Localisation     : in std_logic_vector(3 downto 0);
    i_RX_Data   : in std_logic_vector(3 downto 0);
    i_RX_DV : in std_logic;
    o_TX_Localisation     : out  std_logic_vector(3 downto 0);
    o_TX_Data  : out std_logic_vector(3 downto 0);
    o_TX_en : out std_logic;
    o_Data : out std_logic_vector(51 downto 0);
    CHECK_RES : out std_logic
);
end component;

component check_code_mcu is
  Port ( clock : in std_logic;
         trame : in std_logic_vector (51 downto 0);
         check_enable : in std_logic;
         reset: in std_logic;
         res_enable : out std_logic;
         res : out std_logic         
         );
end component;

component check_date_mcu is
    Port ( 
        JJMMAAAADCCCC : in std_logic_vector (51 downto 0);
        clock : in std_logic;
        check_Enable  : in std_logic;
        reset : in std_logic;
        Res_Enable : out std_logic;
        check_o : out std_logic
    );
end component;


signal clk_int : std_logic;

signal localisation_rx_fpga, data_rx_fpga, localisation_tx_fpga, data_tx_fpga  : std_logic_vector(3 downto 0);
signal localisation_rx_mcu, data_rx_mcu, localisation_tx_mcu, data_tx_mcu: std_logic_vector(3 downto 0);
signal dv_rx_fpga, en_tx_fpga, dv_rx_mcu, en_tx_mcu : std_logic;


signal Res_Enable_Date : std_logic := '0';
signal Res_Date : std_logic := '0';
signal CheckE_Date : std_logic;
signal Reset_Date : std_logic;
signal Res_Enable_Code : std_logic := '0';
signal Res_Code : std_logic := '0';
signal CheckE_Code : std_logic;
signal Reset_Code : std_logic;

signal Trame : std_logic_vector(51 downto 0) := (others => '0');

begin

--LEDTEST <= Res_Enable_Date & Res_Date & CheckE_Date & Res_Enable_Code & Res_Code & CheckE_Code & "00";
LEDTEST <= localisation_tx_fpga & data_tx_fpga;
--LEDTEST <= localisation_rx_fpga & data_rx_fpga;

SevenSeg <= "11111001" when localisation_tx_fpga = "1111" and data_tx_fpga = "0000" else
          "10100100" when localisation_tx_fpga = "1111" and data_tx_fpga = "0001" else
          "10110000";
freq_divider: freq_div port map (clkin => CLOCK, clkout => clk_int);

FPGA_UART_RX: UART_RX_BLOC generic map (g_CLKS_PER_BIT=>651) 
		port map(CLOCK => clk_int, 
					RX_pin => i_UART_RX, 
					localisation_rx => localisation_rx_fpga,
					data_rx => data_rx_fpga,
					rx_dv => dv_rx_fpga
					);

FPGA_UART_TX: UART_TX_BLOC generic map (g_CLKS_PER_BIT=>651) 
		port map(CLOCK => clk_int, 
		            tx_en => en_tx_fpga,
					localisation_tx => localisation_tx_fpga, 
					data_tx => data_tx_fpga,
					TX_pin => o_UART_TX
					);

MCU_UART_RX: UART_RX_BLOC generic map (g_CLKS_PER_BIT=>651) 
		port map(CLOCK => clk_int, 
					RX_pin => i_TEST_UART_RX, 
					localisation_rx => localisation_rx_mcu,
					data_rx => data_rx_mcu, 
					rx_dv => dv_rx_mcu
					);

MCU_UART_TX: UART_TX_BLOC generic map (g_CLKS_PER_BIT=>651) 
		port map(CLOCK => clk_int, 
		            tx_en => en_tx_mcu,
					localisation_tx => localisation_tx_mcu, 
					data_tx => data_tx_mcu,
					TX_pin => o_TEST_UART_TX					
					);

InstFSM : FSM_MAIN
port map (
    i_reset => RESET,
    i_clock => CLOCK,
    Res_Enable_Date => Res_Enable_Date,
    Res_Date => Res_Date,
    CheckE_Date => CheckE_Date,
    Reset_Date => Reset_Date,
    Res_Enable_Code => Res_Enable_Code,
    Res_Code => Res_Code,
    CheckE_Code => CheckE_Code ,
    Reset_Code => Reset_Code,
    i_RX_Localisation  => localisation_rx_fpga,
    i_RX_data  => data_rx_fpga,
    i_RX_DV => dv_rx_fpga,
    o_TX_localisation  => localisation_tx_fpga,
    o_TX_data  => data_tx_fpga,
    o_TX_en => en_tx_fpga,
    o_Data  => Trame,
    CHECK_RES => CHECK_RES
);

Inst_CHECK_CODE_MCU : check_code_mcu
  port map( clock => CLOCK,
         trame => Trame,
         check_enable => CheckE_Code,
         reset => Reset_Code,
         res_enable => Res_Enable_Code,
         res =>  Res_Code       
         );


Inst_CHECK_DATE_MCU : check_date_mcu
port map ( 
        JJMMAAAADCCCC => Trame,
        clock  => CLOCK,
        check_Enable => CheckE_Date,
        reset => Reset_Date,
        Res_Enable => Res_Enable_Date,
        check_o  => Res_Date
    );

end Behavioral;
