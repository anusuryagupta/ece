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
           reset : in STD_LOGIC; -- leftmost switch
           debugmode : in STD_LOGIC; -- second leftmost switch
           invector : in STD_LOGIC_VECTOR(4 downto 0); -- x4 x3 x2 x1 x0
           leds : out STD_LOGIC_VECTOR(1 downto 0); -- leftmost two LEDs corresponding to reset switch and debugmode switch
           modeout : out STD_LOGIC_VECTOR(3 downto 0); -- should convert through displaydecoder and end up in seven-segment
           stateout : out STD_LOGIC_VECTOR(4 downto 0)); -- 1st through 5ths rightmost LEDs
end bikelock;
architecture Behavioral of bikelock is

type state IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);
  -- reset, armed, alarm, counter1, counter2, counter3, counter4, correct5, 
  --counterfalse1, counterfalse2, counterfalse3, counterfalse4, counterfalse3, 
  --counterfalsetwo2, counterfalsetwo3, counterfalsetwo4, counterfalsetwo5
signal current_state, next_state : state;
signal inputs : std_logic_vector(7 downto 0);
signal reset2 : std_logic;
signal debugwire : std_logic_vector(4 downto 0);

begin
  process(clk, invector, inputs, reset, reset2)
  begin
    if reset = '1' then -- if reset switch or reset signal is thrown, send back to initial state of S0
        next_state <= S0;
        inputs <= "10000000";
      elsif reset2 = '1' then
        next_state <= S0;
        reset2 <= '0'; -- if the signal was thrown, turn off the reset signal
        inputs <= "10000000";
      elsif rising_edge(clk) then
        current_state <= next_state; -- see plusthree for motivation
      end if;  
    inputs(4 downto 0) <= invector; -- update the full input group to the most recent input button positions
    case current_state is
        when S0 => -- RESET
          case inputs is
            when '10000000' | '10010000' => -- x4 or nobtn
              next_state <= S0; -- stay in RESET, outvector doesn't change
            when '10000100' => -- x2
              next_state <= S3; -- goto counter1, outvector doesn't change
            when '10001000' | '10000010' | '10000001' => -- x3, x1, x0
              next_state <= S8; -- goto counterfalse1, outvector doesn't change
            when others =>
              reset2 <= 1; -- big nono
          end case;
        when S1 => -- ARMED
          case inputs is
            when '01000000' | '01010000' => -- x4 or nobtn
              next_state <= S1; -- stay in ARMED, outvector doesn't change
            when '01000100' => -- x2
              next_state <= S3; -- goto counter1, outvector doesn't change
            when '01001000' | '01000010' | '01000001' => -- x3, x1, x0
              next_state <= S8; -- goto counterfalse1, outvector doesn't change
            when others =>
              reset2 <= 1; -- big nono
          end case;
        when S2 => -- ALARM
          case inputs is
            when '00100000' | '00110000' | '00101000' | '00100010' | '00100001' => -- x4 or nobtn
              next_state <= S0; -- stay in ALARM, outvector doesn't change
            when '10000100' => -- x2
              next_state <= S3; -- goto counter1, outvector doesn't change
            when others =>
              reset2 <= 1; -- big nono
          end case;
        when S3 => -- counter1
          case inputs is
            when '10000000' | '01000000' | '00100000' =>
              next_state <= S3; -- stay in counter1, outvector doesn't change
            when '10000001' | '01000001' | '00100001' =>
              next_state <= S4; -- goto counter2, outvector doesn't change
            when '00100010' | '00100100' | '00101000' | '00110000' =>
              next_state <= S2; -- goto ALARM, outvector doesn't change
            when '01000100' =>
              next_state <= S13; -- goto counterfalsetwo2, outvector doesn't change
            when '10010000' =>
              next_state <= S0; -- goto RESET
            when '01010000' =>
              next_state <= S1; -- goto ARMED
            when '10001000' | '10000010' | '10001000' | '10000010' | '10000100' =>
              next_state <= S9; -- goto counterfalse2, outvector doesn't change
            when others =>
              reset2 <= 1; -- big nono
          end case;
          -- continue with s4-s16
        when S4 => --counter2
            case inputs is
              when '10000000' | '01000000' | '00100000' => -- when no button
                next_state <= S4; -- stay in counter2
              when '10001000' | '01001000' | '00101000' => -- X3 pressed in any state
                next_state <= S5 --go to counter3
              when '00100010' | '00100100' | '00100001' | '00110000' => --Alarm incorrect
                next_state <= S2; -- goto ALARM, outvector doesn't change
              when '01000100' => -- X2 pressed in 100 or 010
                next_state <= S14; -- goto counterfalsetwo2, outvector doesn't change
              when '10010000' => -- 100 X4 pressed
                next_state <= S0; -- goto RESET
              when '01010000' => -- 010 X4 pressed
                next_state <= S1; -- goto ARMED
              when '01000001' | '01000010' | '10000001' | '10000010' | '10000100' => -- 100 or 010 incorrect - X0 or X1
                next_state <= S10; -- goto counterfalse3, outvector doesn't change
              when others =>
                reset2 <= 1; -- erm guys...
            end case;
          when S5 => -- counter3
            case inputs is
              when '10000000' | '01000000' | '00100000' => -- when no button
                next_state <= S5; -- stay in counter3
              when '10001000' | '01001000' | '00101000' => -- X3 pressed in any state
                next_state <= S6 --go to counter4
              when '00100010' | '00100100' | '00100001' | '00110000' => --Alarm incorrect
                next_state <= S2; -- goto ALARM, outvector doesn't change
              when '01000100' => -- X2 pressed in 100 or 010
                next_state <= S15; -- goto counterfalsetwo3, outvector doesn't change
              when '10010000' => -- 100 X4 pressed
                next_state <= S0; -- goto RESET
              when '01010000' => -- 010 X4 pressed
                next_state <= S1; -- goto ARMED
              when '01000001' | '01000010' | '10000001' | '10000010' | '10000100' => -- 100 or 010 incorrect - X0 or X1
                next_state <= S11; -- goto counterfalse3, outvector doesn't change
              when others =>
                reset2 <= 1; -- erm guys...
            end case;
          when S6 => -- counter4
            case inputs is
              when '10000000' | '01000000' | '00100000' => -- when no button
                next_state <= S6; -- stay in counter3
              when '10000010' | '01000010' | '00100010' => -- X1 pressed in any state
                next_state <= S7 --go to counter4
              when '00101000' | '00100100' | '00100001' | '00110000' => --Alarm incorrect - X4, X3, X2, X0
                next_state <= S2; -- goto ALARM, outvector doesn't change
              when '01000100' => -- X2 pressed in 100 or 010
                next_state <= S16; -- goto counterfalsetwo3, outvector doesn't change
              when '10010000' => -- 100 X4 pressed
                next_state <= S0; -- goto RESET
              when '01010000' => -- 010 X4 pressed
                next_state <= S1; -- goto ARMED
              when '01000001' | '01001000' | '10000001' | '10001000' | '10000100' => -- 100 or 010 incorrect - X0 or X3
                next_state <= S11; -- goto counterfalse3, outvector doesn't change
              when others =>
                reset2 <= 1; -- erm guys...
            end case;
          when S7 => -- counter5
              case inputs is
                when '10000000' | '01000000' | '00100000' => -- when no button
                  next_state <= S7; -- stay in counter7
                when '10010000' => -- 100 X4 pressed
                  next_state <= S1; --go to Armed
                when '01010000' | '10001000' | '10000100' | '10000010' | '10000001'  => -- 010 and X4 OR 100 and wrong
                  next_state <= S0; -- go to reset
                when '00110000' => --001 and X4
                  next_state <= S1; -- go to Armed
                when  '01001000' | '01000100' | '01000010' | '01000001' => -- 010 and wrong
                  next_state <= S2; -- go to alarm
                when others =>
                  reset2 <= 1; -- erm guys...
              end case;
            when S8 => -- counterfalseone
                case inputs is 
                  when '10000000' | '01000000' => -- when no button
                    next_state <= S8; -- stay in S8
                  when '10010000' => -- 100 and X4
                    next_state <= S0; -- return to reset
                  when '01010000' => -- 010 and X4
                    next_state <= S1; -- return to armed
                  when '01000100' => -- 010 and X2
                    next_state <= S13; -- counterfalsetwo2
                  when '10001000' | '10000100' | '10000010' | '10000001' | '01001000' | '01000010' | '01000001' => --100 X3, X2, X1, X0 or 010 X3, X1, X0 pressed
                    next_state <= S9; -- counterfalsetwo
                  when others =>
                    reset2 <= 1; -- erm guys...
                end case;
            when S9 => -- counterfalsetwo
                case inputs is 
                  when '10000000' | '01000000' => -- when no button
                    next_state <= S9; -- stay in S9
                  when '10010000' => -- 100 and X4
                    next_state <= S0; -- return to reset
                  when '01010000' => -- 010 and X4
                    next_state <= S1; -- return to armed
                  when '01000100' => -- 010 and X2
                    next_state <= S14; -- counterfalsetwo2
                  when '10001000' | '10000100' | '10000010' | '10000001' | '01001000' | '01000010' | '01000001' => --100 X3, X2, X1, X0 or 010 X3, X1, X0 pressed
                    next_state <= S10; -- counterfalsefour
                  when others =>
                    reset2 <= 1; -- erm guys...
                end case;
            when S10 => -- counterfalsethree
                case inputs is 
                  when '10000000' | '01000000' => -- when no button
                    next_state <= S10; -- stay in S10
                  when '10010000' => -- 100 and X4
                    next_state <= S0; -- return to reset
                  when '01010000' => -- 010 and X4
                    next_state <= S1; -- return to armed
                  when '01000100' => -- 010 and X2
                    next_state <= S15; -- counterfalsethree2
                  when '10001000' | '10000100' | '10000010' | '10000001' | '01001000' | '01000010' | '01000001' => --100 X3, X2, X1, X0 or 010 X3, X1, X0 pressed
                    next_state <= S11; -- counterfalsefour
                  when others =>
                    reset2 <= 1; -- erm guys...
                end case;
            when S11 => -- counterfalsefour
                case inputs is 
                  when '10000000' | '01000000' => -- when no button
                    next_state <= S11; -- stay in S11
                  when '10010000' => -- 100 and X4
                    next_state <= S0; -- return to reset
                  when '01010000' => -- 010 and X4
                    next_state <= S1; -- return to armed
                  when '01000100' => -- 010 and X2
                    next_state <= S16; -- counterfalsefour2
                  when '10001000' | '10000100' | '10000010' | '10000001' | '01001000' | '01000010' | '01000001' => --100 X3, X2, X1, X0 or 010 X3, X1, X0 pressed
                    next_state <= S12; -- counterfalsefive
                  when others =>
                    reset2 <= 1; -- erm guys...
                end case;
            when S12 => --counterfalsefive
                case inputs is 
                    when '10000000' | '01000000' => -- when no button
                    next_state <= S12; -- stay in counterfalsefive
                    when '10010000' | '10001000' | '10000100' | '10000010' | '10000001' => -- 100 and X4 - X0 pressed
                      next_state <= '10010000' ; -- return to reset
                    when '01010000' | '01001000' | '01000100' | '01000010' | '01000001' => -- 010 and X4 - X0 pressed
                      next_state <= '00100000'; -- go to alarm state
                    when else =>
                      reset2 <= 1; -- erm guys...
                end case;
            when S13 => -- counterfalsetwo2
                case inputs is 
                  when '01000000' => -- 010 no button
                    next_state <= S13; -- stay in counterfalsetwo2
                  when '01000100' => -- 010 and X2
                    next_state <= S1; -- return to armed;
                  when '01010000' | '01001000' | '01000010' | '01000001' => -- 010 and X4,X3,X1,X0
                    next_state <= S10; -- go to counterfalsethree
                  when else =>
                    reset2 <= 1;
                end case;
             when S14 => -- counterfalsethree2
                case inputs is 
                  when '01000000' => -- 010 no button
                    next_state <= S14; -- stay in counterfalsethree2
                  when '01000100' => -- 010 and X2
                    next_state <= S1; -- return to armed;
                  when '01010000' | '01001000' | '01000010' | '01000001' => -- 010 and X4,X3,X1,X0
                    next_state <= S11; -- go to counterfalsefour
                  when else =>
                    reset2 <= 1;
                end case;
             when S15 => -- counterfalsetwo2
                case inputs is 
                  when '01000000' => -- 010 no button
                    next_state <= S15; -- stay in counterfalsefour2
                  when '01000100' => -- 010 and X2
                    next_state <= S1; -- return to armed;
                  when '01010000' | '01001000' | '01000010' | '01000001' => -- 010 and X4,X3,X1,X0
                    next_state <= S12; -- go to counterfalsefive
                  when else =>
                    reset2 <= 1;
                end case;
             when S16 => -- counterfalsefive2
                case inputs is 
                  when '01000000' => -- 010 no button
                    next_state <= S13; -- stay in counterfalsefive2
                  when '01000100' => -- 010 and X2
                    next_state <= S1; -- return to armed;
                  when '01010000' | '01001000' | '01000010' | '01000001' => -- 010 and X4,X3,X1,X0
                    next_state <= S2; -- go to counterfalsethree2
                  when else =>
                    reset2 <= 1;
                end case;
            
        end case;
        modeout(2 downto 0) <= inputs(7 downto 5); -- send inputs(7 downto 5) to modeout
        modeout(3) <= '0';
        -- convert states to 5 bit binary position and send that out to debugwire, probably needs some kind of case statement
          with current_state select
                debugwire(4) <= '1' when S12 | S13 | S14 | S15 | S16, '0' when others;
          with current_state select
                debugwire(3) <= '1' when S7 | S8 | S9 | S10 | S11, '0' when others;
          with current_state select
                debugwire(2) <= '1' when S3 | S4 | S5 | S6 | S8 | S9 | S10 | S11 | S13 | S14 | S15 | S16, '0' when others;
          with current_state select
                debugwire(1) <= '1' when S2 | S5 | S6 | S15 | S16 | S10 | S11, '0' when others;
         with current_state select
                debugwire(0) <= '1' when S1 | S4 | S6  | S9 | S11 | S14 | S16, '0' when others;
        if debugmode = '1' then -- heh. de bug mode. luigi mangione style
          stateout <= debugwire;
        else 
          stateout <= '00000';
        end if;
        -- stateout should map to the LEDs in constraints so we can help test state by state

        if invector /= '00000' then
          wait until invector = '00000'; -- stops one button press from counting as more than one state
          wait for 10 ns; -- debounces button, holds you in this state until button is done bouncing and then continues on rising_edge(clk)
        end if;
    end process;
      

end Behavioral;
 
