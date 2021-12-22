library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity freq_div is
port(
        clkin:in std_logic;
        clkout:out std_logic
    );
end entity freq_div;

architecture behavior of freq_div is
signal count:std_logic_vector(3 downto 0) := "0000";
begin
clkout<=count(3);
process(clkin) is
begin
if rising_edge(clkin) then
	count<=count+1;
end if;
end process;
end architecture behavior;