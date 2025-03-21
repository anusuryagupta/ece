----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2025 09:11:09 AM
-- Design Name: 
-- Module Name: twotofourdecoder - Behavioral
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
library xil_defaultlib;
use xil_defaultlib.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity twotofourdecoder is
    Port (I : in STD_LOGIC_VECTOR(1 downto 0);
          O : out STD_LOGIC_VECTOR(3 downto 0);
          en : in STD_LOGIC);
end twotofourdecoder;

architecture Behavioral of twotofourdecoder is

begin
O(3) <= I(1) and I(0) and en;
O(2) <= I(1) and not I(0) and en;
O(1) <= not I(1) and I(0) and en;
O(0) <= not I(1) and not I(0) and en;

end Behavioral;
