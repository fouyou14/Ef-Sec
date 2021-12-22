library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity check_date_mcu is
    Port ( 
        JJMMAAAADCCCC : in std_logic_vector (51 downto 0);
        clock : in std_logic;
        check_Enable  : in std_logic;
        reset : in std_logic;
        Res_Enable : out std_logic;
        check_o : out std_logic
    );
end check_date_mcu;

architecture Behavioral of check_date_mcu is

component Check 
       Port (
            day : in STD_LOGIC_VECTOR (4 downto 0);
            month : in STD_LOGIC_VECTOR (3 downto 0);
            year : in STD_LOGIC_VECTOR (10 downto 0);
            totalDayNumber : out STD_LOGIC_VECTOR(14 downto 0);
            ok : out std_logic);
end component; 

component LEDManagement
         Port (
            clock : in std_logic;
            reset : in std_logic;
            checkE : in std_logic;
            totalDayNumber : in std_logic_vector (14 downto 0);
            ok : in std_logic;
            led : out std_logic_vector (6 downto 0)
         );
end component;

signal jour : std_logic_vector(4 downto 0);
signal mois : std_logic_vector(3 downto 0);
signal annee : std_logic_vector(10 downto 0);
signal myres : std_logic:= '0';
signal mycheck : std_logic:= '0';
signal jds : std_logic_vector(3 downto 0);

-- Pour le port map
signal tdnb : std_logic_vector (14 downto 0);
signal led : std_logic_vector (6 downto 0);
signal mycheck1: std_logic;
signal c : std_logic;
begin

--checkDate : process(clock, JJMMAAAADCCCC, check_Enable, reset)
--begin
--    if(reset = '1') then
--        myres <= '0';
--        mycheck <= '0';
--        jour <= "00000";
--        annee <= "00000000000";
--        mois <= "0000";
--        c <= '0';
    
--    elsif(rising_edge(clock)) then
--        if(check_enable = '1') then
--            jour <= std_logic_vector(to_unsigned(((to_integer(unsigned(JJMMAAAADCCCC(51 downto 48))))*10 + to_integer(unsigned(JJMMAAAADCCCC(47 downto 44)))), jour'length));
--            mois <= std_logic_vector(to_unsigned(((to_integer(unsigned(JJMMAAAADCCCC(43 downto 40))))*10 + to_integer(unsigned(JJMMAAAADCCCC(39 downto 36)))), mois'length));
--            annee <= std_logic_vector(to_unsigned(((to_integer(unsigned(JJMMAAAADCCCC(35 downto 32))))*1000 + (to_integer(unsigned(JJMMAAAADCCCC(31 downto 28))))*100+(to_integer(unsigned(JJMMAAAADCCCC(27 downto 24))))*10+(to_integer(unsigned(JJMMAAAADCCCC(23 downto 20))))), annee'length));
--            jds <= JJMMAAAADCCCC(19 downto 16);
--            c <= '1';
--            if (led = "1111111" or led = "1000000" or led = "0100000" or led = "0010000"
--            or led = "0001000" or led = "0000100" or led = "0000010" or led = "0000001") then
--                if (led /= "1111111" and ((led = "1000000" and jds = "0001") or (led = "0100000" and jds ="0010")
--                or (led = "0010000" and jds = "0011") or (led = "0001000" and jds = "0100" )
--                or (led = "0000100" and jds ="0101") or (led = "0000010" and jds = "0110") or (led = "0000001" and jds = "0000")))then
--                    myres <= '1';
--                    mycheck <= '1';
--                else
--                    myres <= '1';
--                    mycheck <= '0';
--                end if;
--            end if;
--        else
--            c <= '0';
--        end if;
--    end if;
--end process;

jour <= std_logic_vector(to_unsigned(((to_integer(unsigned(JJMMAAAADCCCC(51 downto 48))))*10 + to_integer(unsigned(JJMMAAAADCCCC(47 downto 44)))), jour'length));
mois <= std_logic_vector(to_unsigned(((to_integer(unsigned(JJMMAAAADCCCC(43 downto 40))))*10 + to_integer(unsigned(JJMMAAAADCCCC(39 downto 36)))), mois'length));
annee <= std_logic_vector(to_unsigned(((to_integer(unsigned(JJMMAAAADCCCC(35 downto 32))))*1000 + (to_integer(unsigned(JJMMAAAADCCCC(31 downto 28))))*100+(to_integer(unsigned(JJMMAAAADCCCC(27 downto 24))))*10+(to_integer(unsigned(JJMMAAAADCCCC(23 downto 20))))), annee'length));
jds <= JJMMAAAADCCCC(19 downto 16);

DateProc : process(clock)
begin
    if reset = '1' then
        myres <= '0';
        mycheck <= '0';
    elsif rising_edge(clock) then
        if check_enable = '1' then
              if (led /= "1111111" and ((led = "1000000" and jds = "0001") or (led = "0100000" and jds ="0010")
                or (led = "0010000" and jds = "0011") or (led = "0001000" and jds = "0100" )
                or (led = "0000100" and jds ="0101") or (led = "0000010" and jds = "0110") or (led = "0000001" and jds = "0000")))then
                    
                    mycheck <= '1';
                else
                    mycheck <= '0';
                end if;
                myres <= '1';
        else
            myres <= '0';
            mycheck <= '0';
        end if;
    end if;
end process;

check_o <= mycheck;
Res_Enable <= myres;

-- Port map --

InstLEDManagement : LEDManagement
    Port map (
        clock => clock,
        reset => reset,
        --checkE => c,
        checkE => check_Enable,
        totalDayNumber => tdnb,
        ok => mycheck1,
        led => led
    );
    
InstCheck : Check 
    Port map ( 
        day => jour,
        month => mois,
        year => annee,
        totalDayNumber => tdnb,
        ok => mycheck1
     );

end Behavioral;