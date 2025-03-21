----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2025 10:50:37 AM
-- Design Name: 
-- Module Name: lab5final - Behavioral
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

entity lab5final is
    Port ( A1 : in STD_LOGIC_VECTOR(2 downto 0);
           B1 : in STD_LOGIC_VECTOR(2 downto 0);
           Cin1 : in STD_LOGIC;
           aout1 : out STD_LOGIC;
           bout1 : out STD_LOGIC;
           cout1 : out STD_LOGIC;
           dout1 : out STD_LOGIC;
           eout1 : out STD_LOGIC;
           fout1 : out STD_LOGIC;
           gout1 : out STD_LOGIC;
           anode1 : out STD_LOGIC_VECTOR(3 downto 0);
           dp1 : out STD_LOGIC);
end lab5final;

architecture Behavioral of lab5final is 
signal sum1: STD_LOGIC_VECTOR (3 downto 0); 

begin
u4: entity threebit port map (A=>A1, B=>B1, Cin=>Cin1, Cout=>sum1(3), sum=>sum1(2 downto 0));
u5: entity inputset port map (a => sum1(3), b => sum1(2), c => sum1(1), d => sum1(0), a1 => aout1, b1 => bout1, c1 => cout1, d1 => dout1, e1 => eout1, f1 => fout1, g1 => gout1, dp => dp1, anode => anode1);
end Behavioral; 
