----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2022 05:00:19 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

Architecture Behavioral of test_env is

component mpg port(
           en : out STD_LOGIC;
           input : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component ssd port ( 
           clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR(3 downto 0);
           digit1 : in STD_LOGIC_VECTOR(3 downto 0);
           digit2 : in STD_LOGIC_VECTOR(3 downto 0);
           digit3 : in STD_LOGIC_VECTOR(3 downto 0);
           cat : out STD_LOGIC_VECTOR(6 downto 0);
           an : out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal en1 : STD_LOGIC;
signal count1, count2, count3, count4 : STD_LOGIC_VECTOR(3 downto 0);

begin

MPG1: mpg port map(en1, btn(0), clk);
MPG2: mpg port map(en1, btn(1), clk);
MPG3: mpg port map(en1, btn(2), clk);
SSDMap: ssd port map(clk, count3, count4, count1, count2, cat, an);

count1 <= "0000";
count2 <= "0000";
count3 <= "0000";
count4 <= "0000";

--count2 count1 count4 count3    

Reset: process(clk)
begin
    if rising_edge(clk) then
        if btn(0) <= '1' then
            count1 <= "0000";
            count2 <= "0000";
            count3 <= "0000";
            count4 <= "0000";
        end if;
    end if;
end process;

LeftScoreboardIncrement: process(clk)
begin
    if rising_edge(clk) then
        if sw(0) <= '0' then
            if btn(1) = '1' then
                if count2 /= 9 then
                    if count1 /= 9 then
                        count1 <= count1;
                    else
                        count1 <= count1 + 1;
                    end if;
                else
                    if count1 /= 9 then
                        count1 <= count1 + 1;
                    else
                        count1 <= "0000";
                        count2 <= count2 + 1;
                    end if; 
                end if;
            end if;
        end if;
    end if;
end process;

RightScoreboardIncrement: process(clk)
begin
    if rising_edge(clk) then
        if sw(0) <= '1' then
            if btn(1) = '1' then
                if count4 /= 9 then
                    if count3 /= 9 then
                        count3 <= count3;
                    else
                        count3 <= count3 + 1;
                    end if;
                else
                    if count3 /= 9 then
                        count3 <= count3 + 1;
                    else
                        count3 <= "0000";
                        count4 <= count4 + 1;
                    end if; 
                end if;
            end if;
        end if;
    end if;
end process;

LeftScoreboardDecrement: process(clk)
begin
    if rising_edge(clk) then
        if sw(0) <= '0' then
            if btn(2) = '1' then
                if count2 /= 0 then
                    if count1 /= 0 then
                        count1 <= count1;
                    else
                        count1 <= count1 - 1;
                    end if;
                else
                    if count1 /= 0 then
                        count1 <= count1 - 1;
                    else
                        count1 <= "1001";
                        count2 <= count2 - 1;
                    end if; 
                end if;
            end if;
        end if;
    end if;
end process;

RightScoreboardDecrement: process(clk)
begin
    if rising_edge(clk) then
        if sw(0) <= '1' then
            if btn(2) = '1' then
                if count4 /= 0 then
                    if count3 /= 0 then
                        count3 <= count3;
                    else
                        count3 <= count3 - 1;
                    end if;
                else
                    if count3 /= 0 then
                        count3 <= count3 - 1;
                    else
                        count3 <= "1001";
                        count4 <= count4 - 1;
                    end if; 
                end if;
            end if;
        end if;
    end if;
end process;

end Behavioral;
