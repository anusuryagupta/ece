----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2025 09:43:17 PM
-- Design Name: 
-- Module Name: bikelock - Behavioral
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

entity bikelock is
  Port (   clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           invector : in STD_LOGIC_VECTOR(4 downto 0); -- x4 x3 x2 x1 x0
           masterout : out STD_LOGIC_VECTOR(3 downto 0);
           stateout : out STD_LOGIC_VECTOR(5 downto 0));
end bikelock;

architecture Behavioral of bikelock is

type state IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);
  -- reset, armed, alarm, counter1, counter2, counter3, counter4, correct5, 
  --counterfalse1, counterfalse2, counterfalse3, counterfalse4, counterfalse3, 
  --counterfalsetwo2, counterfalsetwo3, counterfalsetwo4, counterfalsetwo5
signal current_state, next_state : state;
signal inputs : std_logic_vector(7 downto 0);
signal reset2 : in std_logic;

begin
  process(clk, invector, inputs, reset, reset2)
  begin
    if reset = '1' then
        next_state <= S0;
        inputs <= "10000000";
      elsif reset2 = '1' then
        next_state <= S0;
        reset2 <= '0';
        inputs <= "10000000";
      elsif rising_edge(clk) then
        current_state <= next_state;
      end if;  
    inputs(4 downto 0) <= invector;
    case current_state is
        when S0 => -- reset
          case inputs is
            when '10000000' | '10010000' => -- x4 or nobtn
              next_state <= S0; -- stay in RESET
              inputs(7 downto 5) <= '100';
            when '10000100' => -- x2
              next_state <= S3; -- goto counter1
              inputs(7 downto 5) <= '100';
            when '10001000' | '10000010' | '10000001' => -- x3, x1, x0
              next_state <= S8; -- goto counterfalse1
              inputs(7 downto 5) <= '100';
            when others =>
              reset2 <= 1; -- big nono
          end case;
        when S3 =>
            case inputs is
              when '10000000' | '01000000' | '00100000' =>
                next_state <= S3; -- stay in counter1, outvector doesn't change
              when '10000001' =>
                next_state <= S4; -- goto counter2, outvector doesn't change
              when '00100010' | '00100100' | '00101000' | '00110000' =>
                next_state <= S2; -- goto ALARM, outvector doesn't change
              when '10000100' | '01000100' =>
                next_state <= S13; -- goto counterfalsetwo2, outvector doesn't change
              when '10010000' =>
                next_state <= S0; -- goto RESET
              when '01010000' =>
                next_state <= S1; -- goto ARMED
              when '10001000' | '10000010' | '10001000' | '10000010' =>
                next_state <= S9; -- goto counterfalse2, outvector doesn't change
              when others =>
                reset2 <= 1; -- big nono
              end case;
              
      
      

end Behavioral;
 
