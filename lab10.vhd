----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2025 09:47:37 AM
-- Design Name: 
-- Module Name: lab10 - Behavioral
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

library xil_defaultlib;
use xil_defaultlib.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab10 is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        segment : out STD_LOGIC_VECTOR (6 downto 0);  -- A at 6, G at 0
        anodedp : out STD_LOGIC_VECTOR (4 downto 0)); -- dp at 4, anode at 3 to 0
end lab10;

architecture Behavioral of lab10 is
signal output : std_logic_vector(3 downto 0);
begin
u1: entity plusthree port map (clk => clk, reset => reset, output => output);
u2: entity displaydecoder port map (num => output, segment => segment, anodedp => anodedp);

end Behavioral;
