library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity FSM_MAIN_tb is
end FSM_MAIN_tb;
 
architecture Behavioral of FSM_MAIN_tb is

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
    o_TX_Localisation     : out std_logic_vector(3 downto 0);
    o_TX_Data   : out std_logic_vector(3 downto 0);
    o_TX_en : out std_logic;
    o_Data : out std_logic_vector(51 downto 0);
    CHECK_RES : out std_logic
);
end component;

signal reset : std_logic;
signal clk : std_logic;
signal Res_Enable_Date : std_logic := '0';
signal Res_Date : std_logic := '0';
signal CheckE_Date : std_logic;
signal Reset_Date : std_logic;

signal Res_Enable_Code : std_logic := '0';
signal Res_Code : std_logic := '0';
signal CheckE_Code : std_logic;
signal Reset_Code : std_logic;
signal i_rx_localisation, i_rx_data, o_tx_localisation, o_tx_data : std_logic_vector(3 downto 0);
signal o_Data : std_logic_vector(51 downto 0) := (others => '0');
signal CHECK_RES : std_logic;

signal dv_rx_fpga : std_logic;
signal en_tx_fpga : std_logic;
begin

InstFSM : FSM_MAIN
port map (
    i_reset => reset,
    i_clock => clk,
    Res_Enable_Date => Res_Enable_Date,
    Res_Date => Res_Date,
    CheckE_Date => CheckE_Date,
    Reset_Date => Reset_Date,
    Res_Enable_Code => Res_Enable_Code,
    Res_Code => Res_Code,
    CheckE_Code => CheckE_Code ,
    Reset_Code => Reset_Code,
    i_RX_Localisation  => i_rx_localisation,
    i_RX_Data => i_rx_data,
    i_RX_DV => dv_rx_fpga,
    o_TX_Localisation  => o_tx_localisation,
    o_TX_Data    => o_tx_data,
    o_TX_en => en_tx_fpga,
    o_Data  => o_Data,
    CHECK_RES => CHECK_RES
);



         data : process
      begin
      
        i_rx_localisation <= "0000";
        i_rx_data <= "0010";
--      wait for 25 ms;
--      i_RX_Byte <= "00010001";
--      wait for 25 ms;
--      i_RX_Byte <= "00100001";
--      wait for 25 ms;
--      i_RX_Byte <= "00110000";
--      wait for 25 ms;
--      i_RX_Byte <= "01000001";
--      wait for 25 ms;
     
--      i_RX_Byte <= "01011001";
--      wait for 25 ms;
--      i_RX_Byte <= "01100110";
--      wait for 25 ms;
--      i_RX_Byte <= "01110101";
--      wait for 25 ms;
--      i_RX_Byte <= "10000010";
--      wait for 25 ms;
--      i_RX_Byte <= "00001011"; -- i_RX_Byte = * ==> reset
--      wait for 25 ms;
--      i_RX_Byte <= "10010001";
--      wait for 25 ms;
--      i_RX_Byte <= "10100010";
--      wait for 25 ms;
--      i_RX_Byte <= "10110011";
--      wait for 25 ms;
--      i_RX_Byte <= "11000100";
--      wait for 25 ms;
--      i_RX_Byte <= "11010101";
--      wait for 25 ms;
--      i_RX_Byte <= "00001110"; -- i_RX_Byte = # ==> validate
--      wait; 
      end process;
      
      ResetProc : process
      begin
        reset <= '0';
        wait for 130 ms;
        reset <= '1';
        wait for 20 ms;
        reset <= '0';
        wait;
      end process;
      
      ClockProc : process
      begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
      end process;
end Behavioral;