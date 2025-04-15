----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2025 09:43:17 PM
-- Design Name: 
-- Module Name: eighttothreeencoder - Behavioral
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

entity eighttothreeencoder is
  Port (   I : in STD_LOGIC_VECTOR (7 downto 0); -- A B C x4 x3 x2 x1 x0, the x's should be priorityencoder(thatnumber)
           O : out STD_LOGIC_VECTOR (4 downto 0)); -- binary input that represents that input group
end eighttothreeencoder;

architecture Behavioral of eighttothreeencoder is
begin
with num select
    O(4) <= '1' when "10010000" | "10001000" | "10000100" | "10000010" | "10000001" | "10000000" | "01010000" | "01001000" | "01000100" | "01000010" | "01000001" | "01000000", '0' when others; -- master state 1
with num select
    O(3) <= '1' when "10010000" | "10001000" | "10000100" | "10000010" | "10000001" | "10000000", '0' when others; -- master state 0
with num select
    O(2) <= '1' when "10010000" | "01010000" | "00110000", '0' when others; -- x button 2
with num select
    O(1) <= '1' when "10001000" | "01001000" | "00101000" | "10000100" | "01000100" | "00100100", '0' when others; -- x button 1
with num select
    O(0) <= '1' when "10000010" | "01000010" | "00100010" | "10000001" | "01000001" | "00100001", '0' when others; -- x button 0

end Behavioral;
 
