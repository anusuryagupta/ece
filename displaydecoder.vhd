----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2025 09:43:17 PM
-- Design Name: 
-- Module Name: displaydecoder - Behavioral
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
library xil_defaultlib;
use xil_defaultlib.all;

entity displaydecoder is
  Port (   num : in STD_LOGIC_VECTOR (3 downto 0); 
           segment : out STD_LOGIC_VECTOR (6 downto 0);  -- A at 6, G at 0
           anodedp : out STD_LOGIC_VECTOR (4 downto 0)); -- dp at 4, anode at 3 to 0
end displaydecoder;

architecture Behavioral of displaydecoder is

begin
with num select
    segment(6) <= '1' when "0001" | "0100" | "1011" | "1101", '0' when others; -- A
with num select
    segment(5) <= '1' when "0101" | "0110" | "1011" | "1100" | "1110" | "1111", '0' when others; -- B
with num select
    segment(4) <= '1' when "0010" | "1100" | "1110" | "1111", '0' when others; -- C
with num select
    segment(3) <= '1' when "0001" | "0100" | "0111" | "1010" | "1111", '0' when others; -- D
with num select
    segment(2) <= '1' when "0001" | "0011" | "0100" | "0101" | "0111" | "1001",'0' when others; -- E
with num select
    segment(1) <= '1' when "0001" | "0010" | "0011" | "0111" | "1101", '0' when others; -- F
with num select
    segment(0) <= '1' when "0000" | "0001" | "0111" | "1100", '0' when others; -- G
anodedp <= "11110";

end Behavioral;
 