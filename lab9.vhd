----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2025 10:05:09 AM
-- Design Name: 
-- Module Name: lab9 - Behavioral
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

entity lab9 is
    Port (D : in STD_LOGIC_VECTOR(3 downto 0);
          S : in STD_LOGIC_VECTOR(1 downto 0);
          W : in STD_LOGIC;
          clk : in STD_LOGIC;
          Y : out STD_LOGIC_VECTOR(3 downto 0));
end lab9;

architecture Behavioral of lab9 is
signal q_0 : STD_LOGIC_VECTOR(3 downto 0);
signal q_1 : STD_LOGIC_VECTOR(3 downto 0);
signal q_2 : STD_LOGIC_VECTOR(3 downto 0);
signal q_3 : STD_LOGIC_VECTOR(3 downto 0);
signal en : STD_LOGIC := (w and clk);
signal regclock : STD_LOGIC_VECTOR(3 downto 0);

begin
u1: entity fourbitregister port map (clk => regclock(0), q => q_0, d => d);
u2: entity fourbitregister port map (clk => regclock(1), q => q_1, d => d); 
u3: entity fourbitregister port map (clk => regclock(2), q => q_2, d => d);
u4: entity fourbitregister port map (clk => regclock(3), q => q_3, d => d);
u5: entity twotofourdecoder port map (i => s, en => en, O => regclock);
u6: entity multiplexer port map (a => q_0, b => q_1, c => q_2, d => q_3, s => s, y => y);


end Behavioral;
