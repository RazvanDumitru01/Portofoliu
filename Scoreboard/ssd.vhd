----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2022 10:51:57 PM
-- Design Name: 
-- Module Name: ssd - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ssd is
    Port (
        clk    : in  STD_LOGIC;
        digit0 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit1 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit2 : in  STD_LOGIC_VECTOR(3 downto 0);
        digit3 : in  STD_LOGIC_VECTOR(3 downto 0);
        cat    : out STD_LOGIC_VECTOR(6 downto 0);
        an     : out STD_LOGIC_VECTOR(3 downto 0));
end ssd;

architecture Behavioral of ssd is

signal s_counter : std_logic_vector(15 downto 0) := X"0000";
signal s_mux_top : std_logic_vector(3 downto 0)  := X"0";

begin

counter : process(clk)
begin
    if rising_edge(clk) then
        s_counter <= s_counter + 1;
    end if;
end process;


mux_top : process(s_counter(15 downto 14), digit0, digit1, digit2, digit3)
begin
    case s_counter(15 downto 14) is
        when "00" => s_mux_top <= digit3;
        when "01" => s_mux_top <= digit2;
        when "10" => s_mux_top <= digit1;
        when "11" => s_mux_top <= digit0;
        when others => s_mux_top <= digit3;
    end case;
end process;

mux_bottom : process(s_counter(15 downto 14))
begin
    case s_counter(15 downto 14) is
        when "00" => an <= "1110";
        when "01" => an <= "1101";
        when "10" => an <= "1011";
        when "11" => an <= "0111";
        when others => an <= "1110";
    end case;
end process;
    
decoder : process(s_mux_top)
begin
    case s_mux_top is
        when "0001" => cat <= B"111_1001"; -- 1
        when "0010" => cat <= B"010_0100"; -- 2
        when "0011" => cat <= B"011_0000"; -- 3
        when "0100" => cat <= B"001_1001"; -- 4
        when "0101" => cat <= B"001_0010"; -- 5
        when "0110" => cat <= B"000_0010"; -- 6
        when "0111" => cat <= B"111_1000"; -- 7
        when "1000" => cat <= B"000_0000"; -- 8
        when "1001" => cat <= B"001_0000"; -- 9
        when "1010" => cat <= B"000_1000"; -- A
        when "1011" => cat <= B"000_0011"; -- b
        when "1100" => cat <= B"100_0110"; -- C
        when "1101" => cat <= B"010_0001"; -- d
        when "1110" => cat <= B"000_0110"; -- E
        when "1111" => cat <= B"000_1110"; -- F
        when others => cat <= B"100_0000"; -- 0
    end case;
end process;
    
end Behavioral;
