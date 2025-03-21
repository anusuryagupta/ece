----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:35:34 PM
-- Design Name: 
-- Module Name: fourtotwodecoder - Behavioral
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

entity fourtotwodecoder is
    Port ( I : in STD_LOGIC_VECTOR(3 downto 0);
           O : out STD_LOGIC_VECTOR(1 downto 0);
           V : out STD_LOGIC );
end fourtotwodecoder;

architecture Behavioral of fourtotwodecoder is
    
    

begin
with I select
     V <= '1' when "0000", '0' when others;
with I select
     O(1) <= '0' when "0010" | "0011" | "0001" | "0000", '1' when others;
with I select
     O(0) <= '0' when "0100" | "0101" | "0110" | "0111" | "0001" | "0000", '1' when others;

end Behavioral;
