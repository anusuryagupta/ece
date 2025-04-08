----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2025 09:23:04 AM
-- Design Name: 
-- Module Name: plusthree - Behavioral
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

entity plusthree is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        output  : out STD_LOGIC_VECTOR (3 downto 0));
end plusthree;

architecture Behavioral of plusthree is
    type state is (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P);
    signal current_state, next_state : state;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= A;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state)
    begin
        case current_state is
            when A => next_state <= B;  -- 0 → 3
            when B => next_state <= C;  -- 3 → 6
            when C => next_state <= D;  -- 6 → 9
            when D => next_state <= E;  -- 9 → 12
            when E => next_state <= F;  -- 12 → 15
            when F => next_state <= G;  -- 15 → 2
            when G => next_state <= H;  -- 2 → 5
            when H => next_state <= I;  -- 5 → 8
            when I => next_state <= J;  -- 8 → 11
            when J => next_state <= K;  -- 11 → 14
            when K => next_state <= L; -- 14 -> 1            
            when L => next_state <= M;  -- 1 → 4
            when M => next_state <= N;  -- 4 → 7
            when N => next_state <= O;  -- 7 → 10
            when O => next_state <= P;  -- 10 → 13
            when P => next_state <= A;  -- 13 → 0
            when others => next_state <= A;
        end case;
    end process;

    process(current_state)
    begin
        case current_state is
            when A => output <= "0000";  -- 0
            when B => output <= "0011";  -- 3 
            when C => output <= "0110";  -- 6 
            when D => output <= "1001";  -- 9 
            when E => output <= "1100";  -- 12
            when F => output <= "1111";  -- 15
            when G => output <= "0010";  -- 2 
            when H => output <= "0101";  -- 5 
            when I => output <= "1000";  -- 8 
            when J => output <= "1011";  -- 11
            when K => output <= "1110"; -- 14             
            when L => output <= "0001";  -- 1 
            when M => output <= "0100";  -- 4 
            when N => output <= "0111";  -- 7 
            when O => output <= "1010";  -- 10 
            when P => output <= "1101";  -- 13 
            when others => output <= "0000";
        end case;
    end process;

end Behavioral;
