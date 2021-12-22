
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_partie2 is
end tb_partie2;

architecture Behavioral of tb_partie2 is

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

signal clk, reset, i_uart_rx, o_uart_tx, i_test_uart_rx, o_test_uart_tx, check_res : std_logic;
signal switch : std_logic_vector(3 downto 0);
signal myled : std_logic_vector(7 downto 0);
signal SevenSeg : std_logic_vector(7 downto 0);
begin

InstDesign2 : design_Partie_2
generic map(
    g_CLKS_PER_BIT => 651
    )
port map(
    CLOCK  => clk,
    RESET  => reset,
    SWITCH  => switch,
    
    i_UART_RX   => i_uart_rx,
    o_UART_TX   => o_uart_tx,
    
    i_TEST_UART_RX   => i_test_uart_rx,
    o_TEST_UART_TX   => o_test_uart_tx,
    
    CHECK_Res   => check_res,
    
    LEDTEST => myled,
    
    SevenSeg => SevenSeg

	 );
	 
	
    -- Description des évolutions des signaux d'entrées (stimuli)
    	-- Description de l'évolution de l'horloge clkin
    	MyclkProc : process
        begin
        	clk <= '0';
            WAIT FOR 5 ns;
            clk <= '1';
            WAIT FOR 5 ns;
        end process;
        
        -- Description de l'évolution de l'entrée resetin
        MyResetProc : process
        begin
        	reset <= '1';
        	wait for 15 ns;
        	reset <= '0';
--            WAIT FOR 520 ms;
--            resetin <= '1';
--            WAIT FOR 15 ns;
--            resetin <= '0';
            wait;
        end process; 
        
        MyRXProc : process
        begin
        i_uart_rx <= '1';
        wait for 104 us;
        
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 300 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        
        wait for 104 us;
        
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '0';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait for 104 us;
        i_uart_rx <= '1';
        wait;        
        end process;


end Behavioral;
