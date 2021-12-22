library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity check_code_mcu is
  Port ( clock : in std_logic;
  -- trame est l ensemble date et code
         trame : in std_logic_vector (51 downto 0);
         check_enable : in std_logic;
         reset: in std_logic;
         res_enable : out std_logic;
         res : out std_logic         
         );
end check_code_mcu;

architecture Behavioral of check_code_mcu is

signal ressig : std_logic;
signal res_enablesig : std_logic;


type ROM is array (5 downto 0) of std_logic_vector(51 downto 0);
signal mem : ROM := ("0010011000000110000110010110010101101000000110000001", -- tom 2606196568181
                    "0001001000001000000110010111000000110001010001000001", -- paul 1208197031441
                    "0010001000000001000110011001010100000110010101000111", -- clement 2201199506547
                    "0001000100000110000110010111000101011000000110000111", -- mickael 1106197158187
                    "0011000100000101000110010101010100100110011101110100", -- ilan 3105195526774
                    "0000001100010010000110011000010000010101010101010101"); -- kevin 0312198415555
                    
begin

checkcode : process (clock, trame, check_enable)
begin
    if reset = '1' then 
        ressig <= '0';
        res_enablesig <= '0';
    elsif rising_edge(clock) then
        if check_enable = '1' then
            ressig <= '0';
            for i in mem' range loop
                if mem(i) = trame then 
                    ressig <= '1';
                end if;
            end loop;
            res_enablesig <= '1';
        end if; 
    end if;
end process;

res <= ressig;
res_enable <= res_enablesig;

end Behavioral;
