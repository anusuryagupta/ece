----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2025 09:06:08 AM
-- Design Name: 
-- Module Name: threebit - Behavioral
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

entity threebit is
    Port ( A : in STD_LOGIC_VECTOR(2 downto 0);
           B : in STD_LOGIC_VECTOR(2 downto 0);
           Cin : in STD_LOGIC;
           cout : out STD_LOGIC;
           sum : out STD_LOGIC_VECTOR(2 downto 0));
end threebit;

architecture Behavioral of threebit is
signal carry0 : std_logic;
signal carry1 : std_logic;

begin

u1: entity lab4 port map (a=> A(0), b=> B(0), cin=> Cin, cout=> carry0, sum=> sum(0));
u2: entity lab4 port map (a=> A(1), b=> B(1), cin=> carry0, cout=> carry1, sum=> sum(1));
u3: entity lab4 port map (a=> A(2), b=> B(2), cin=> carry1, cout=> cout, sum=> sum(2));

end Behavioral;
