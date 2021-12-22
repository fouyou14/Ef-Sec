-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- Description de l'entitée -> Vue externe
entity MyMod4 is
	port (
    	clock : in std_logic;
        reset : in std_logic;
        clockEnableDisplay : in std_logic;
        AN : out std_logic_vector (3 downto 0);
        mod4 : out std_logic_vector (1 downto 0)
	);
end MyMod4;

-- Description de l'architecture -> vue interne
architecture MyMod4Arch of MyMod4 is
	
-- Zone de déclaration des signaux et composants...
	signal myModFour : std_logic_vector (1 downto 0);
    signal myAn : std_logic_vector (3 downto 0);
    
begin

	-- Zone de description des instances et des process (dans le begin)
    MyMod4Proc_01 : process (clock, reset)
    begin
    	-- Instruction séquentielles
    	if (reset = '1') then
        	myModFour <= (others => '0');
        elsif rising_edge(clock) then
        	if (clockEnableDisplay = '1') then
                if (myModFour = "11") then
                    myModFour <= "00";
                else
                    myModFour <= myModFour + 1;
                end if;
            end if;
        end if;
    end process;
    
    MyAnProc_02 : process(clock, reset, myModFour)
    begin
    	if (reset = '1') then
        	myAn <= (others => '1');
        elsif rising_edge(clock) then
        	if (clockEnableDisplay = '1') then
                case (myModFour) is
                	when "00" =>
                    	myAn <= "0001";
                    
                    when "01" =>
                    	myAn <= "0010";
                    
                    when "10" =>
                    	myAn <= "0100";
                    
                    when "11" =>
                    	myAn <= "1000";  
                        
                    when others =>
                    	myAn <= "0000";
                        
                 end case;
            end if;
        end if;
    end process;
    
    --Raccordement du signal de sortie au signal interne
    mod4 <= myModFour;
    AN <= myAn;
    
end MyMod4Arch;