----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2025 09:43:17 PM
-- Design Name: 
-- Module Name: finalproject - Behavioral
-- finalproject Name: 
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

entity finalproject is
  Port (   num : in STD_LOGIC_VECTOR (4 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           debug : in STD_LOGIC;
           debuglights : out STD_LOGIC_VECTOR (4 downto 0);
           ledout : out STD_LOGIC_VECTOR (1 downto 0);
           segment : out STD_LOGIC_VECTOR (6 downto 0);  -- A at 6, G at 0
           anodedp : out STD_LOGIC_VECTOR (4 downto 0)); -- dp at 4, anode at 3 to 0
end finalproject;
  
architecture Behavioral of finalproject is
  
signal transfer : std_logic_vector(4 downto 0); -- priority O to bikelock in
signal lightsout : std_logic_vector(3 downto 0); -- bikelock mode to seven segment

begin

u1: entity fivebitprioritydecoder.vhd port map(I => num, O => transfer);
u2: entity bikelock.vhd port map(clk => clk, reset => reset, debugmode => debug, invector => transfer, leds => ledout, stateout => debuglights, modeout => lightsout);
u3: entity displaydecoder.vhd port map(num => lightsout, segment => segment, anodedp => anodedp);
  
end Behavioral;
 
