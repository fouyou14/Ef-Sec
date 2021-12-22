----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2021 14:16:43
-- Design Name: 
-- Module Name: Mux4to1 - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux4to1 is
    port(   disp0, disp1, disp2, disp3 : in    std_logic_vector(7 downto 0); 
            mod4 : in    std_logic_vector(1 downto 0); 
     	    sevenSeg : out   std_logic_vector(7 downto 0) 
    ); 
end Mux4to1;

architecture Behavioral of Mux4to1 is

begin

process(disp0, disp1, disp2, disp3, mod4) is 
begin 
      case mod4 is 
        when "00"   => sevenSeg <= disp0; 
        when "01"   => sevenSeg <= disp1; 
        when "10" 	=> sevenSeg <= disp2; 
        when others => sevenSeg <= disp3; 
      end case; 
end process; 

end Behavioral;
