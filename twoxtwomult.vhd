----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 07:02:33 PM
-- Design Name: 
-- Module Name: twoxtwomult - Behavioral
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

entity twoxtwomult is
    Port ( A : in STD_LOGIC_VECTOR(1 downto 0);
           B : in STD_LOGIC_VECTOR(1 downto 0);
           M : out STD_LOGIC_VECTOR(3 downto 0) );
end twoxtwomult;

architecture Behavioral of twoxtwomult is

begin
M(3) <= A(1) and A(0) and B(1) and B(0);
M(2) <= (A(1) and not A(0) and B(1)) or (A(1) and B(1) and not B(0));
M(1) <= (A(1) and not B(1) and B(0)) or (A(0) and B(1) and not B(0)) or (B(0) and A(1) and not A(0)) or (B(1) and not A(1) and A(0));
M(0) <= A(0) and B(0);

end Behavioral;
