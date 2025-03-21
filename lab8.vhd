----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2025 08:09:32 PM
-- Design Name: 
-- Module Name: lab8 - Behavioral
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

entity lab8 is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Func : in STD_LOGIC_VECTOR(3 downto 0);
           Segment : out STD_LOGIC_VECTOR (6 downto 0);
           AnodeDp : out STD_LOGIC_VECTOR (4 downto 0) );
end lab8;

architecture Behavioral of lab8 is
signal sumvector : std_logic_vector(3 downto 0);
signal subvector : std_logic_vector(3 downto 0);
signal mulvector : std_logic_vector(3 downto 0);
signal andvector : std_logic_vector(3 downto 0);
signal Binv : std_logic_vector(3 downto 0) := not B;
signal selector : std_logic_vector(1 downto 0);
signal valid : std_logic;
signal subinv : std_logic;

begin
u1: entity threebit port map (A=> A(2 downto 0), B => B(2 downto 0), Cin => '0', Cout => sumvector(3), Sum => sumvector(2 downto 0));
u2: entity threebit port map (A=> A(2 downto 0), B => Binv(2 downto 0), Cin => '1', Cout => subinv, Sum => subvector(2 downto 0));
subvector(3) <= not subinv;
u3: entity twoxtwomult port map (A=> A(1 downto 0), B => B(1 downto 0), M => mulvector);
u4: entity fourbitand port map (A=> A, B => B, C => andvector);
u5: entity fourtotwodecoder port map (I=> Func, O => selector, V => valid);
u6: entity multiplexer port map (A => sumvector, B => subvector, C => mulvector, D => andvector, S => selector, display => Segment);
AnodeDp(4) <= valid; -- an0
AnodeDp(3) <= '1'; -- an3
AnodeDp(2) <= '1'; -- an2
AnodeDp(1) <= '1'; -- an1
AnodeDp(0) <= '1'; -- dp


end Behavioral;
