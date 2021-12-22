library ieee;
use ieee.std_logic_1164.all;

entity byte_gen is
port(
      en : in std_logic;
      id_i : in std_logic_vector(3 downto 0);
	  code_i : in std_logic_vector(3 downto 0);
	  byte_o : out std_logic_vector(7 downto 0)
	  );
end entity byte_gen;

architecture behavior of byte_gen is
begin
process(id_i, code_i) is
begin
    if(en = '1') then
        byte_o <= id_i & code_i;
    end if;
end process;
end architecture behavior;