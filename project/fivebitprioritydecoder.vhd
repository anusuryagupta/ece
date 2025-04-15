----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2025 09:43:17 PM
-- Design Name: 
-- Module Name: fivebitprioritydecoder - Behavioral
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

entity fivebitprioritydecoder is
  Port (   I : in STD_LOGIC_VECTOR (4 downto 0); 
           O : out STD_LOGIC_VECTOR (5 downto 0)); -- nobtn at 5, x4 at 4, x3 at 3, etc
end fivebitprioritydecoder;

architecture Behavioral of fivebitprioritydecoder is
-- priority should be x4 > x3 > x2 > x1 > x0
begin
with num select
    O(5) <= '1' when "00000", '0' when others; --nobtn
with num select
    O(4) <= '1' when "10000" | "10001" | "10010" | "10011" | "10100" | "10101" | "10110" | "10111" | "11000" | "11001" | "11010" | "11011" | "11100" | "11101" | "11110" | "11111", '0' when others; -- x4
with num select
    O(3) <= '1' when "01000" | "01001" | "01010" | "01011" | "01100" | "01101" | "01110" | "01111", '0' when others; -- x3
with num select
    O(2) <= '1' when "00100" | "00101" | "00110" | "00111", '0' when others; -- x2
with num select
    O(1) <= '1' when "00010" | "00011", '0' when others; -- x1
with num select
    O(0) <= '1' when "00001", '0' when others; -- x0

end Behavioral;
 
