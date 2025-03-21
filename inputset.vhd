----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2025 09:18:18 AM
-- Design Name: 
-- Module Name: inputset - Behavioral
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

entity inputset is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           aout : out STD_LOGIC;
           bout : out STD_LOGIC;
           cout : out STD_LOGIC;
           dout : out STD_LOGIC;
           eout : out STD_LOGIC;
           fout : out STD_LOGIC;
           gout : out STD_LOGIC; 
           dp : out STD_LOGIC;
           anode : out STD_LOGIC_VECTOR(3 downto 0));
end inputset;

architecture Behavioral of inputset is

begin
aout <= ((not a) and b and (not c) and (not d)) or ((not a) and (not b) and (not c) and d) or (a and b and (not c) and d) or (a and (not b) and c and d);
bout <= (b and c and (not d)) or (a and b and (not d)) or (a and c and d) or ((not a) and b and (not c) and d);
cout <= (a and b and (not d)) or (a and b and c) or ((not a) and (not b) and c and (not d));
dout <= ((not b) and (not c) and d) or (b and c and d) or (a and (not b) and c and (not d)) or ((not a) and b and (not c) and (not d));
eout <= ((not a) and d) or ((not b) and (not c) and d) or ((not a) and b and (not c));
fout <= ((not a) and (not b) and d) or ((not a) and (not b) and c) or ((not a) and c and d) or (a and b and (not c) and d); 
gout <= ((not a) and (not b) and (not c)) or (a and b and (not c) and (not d)) or ((not a) and b and c and d);
dp <= a or (not a);
anode <= "1110";



end Behavioral;
