----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2025 08:47:05 PM
-- Design Name: 
-- Module Name: 2to4decoder - Behavioral
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

entity twofourdecoder is
    Port ( input : in STD_LOGIC_VECTOR (2 downto 0); -- MSB is enable, middle and LSB are A1 and A0
           output : out STD_LOGIC_VECTOR (3 downto 0));
end twofourdecoder;

architecture Behavioral of twofourdecoder is

begin
with input select
    output <= "1000" when "100",
              "0100" when "101",
              "0010" when "110",
              "0001" when "111",
              "0000" when others;
    

end Behavioral;
