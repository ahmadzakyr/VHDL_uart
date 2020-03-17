----------------------------------------------------------------------------------
-- Engineer: AZR
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
-- Target Devices: xc7a35t
-- Tool Versions: 16.1
-- Description: core
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity baud_gen is
	generic( BAUD_DIV   : std_logic_vector(6 downto 0) :=  "0000010");                  
	port(                            
            clk_i    : in std_logic;                                             
            rstn_i   : in std_logic;     
            baud_o   : out std_logic       
         
    );
end entity baud_gen;

architecture rtl of baud_gen is


signal mcount        : std_logic_vector(5 downto 0);
signal count         : std_logic_vector(6 downto 0);  
signal clk_260_800   : std_logic;  


begin 

    process(rstn_i, clk_i)
    begin
        if rstn_i = '0' then
            mcount      <= (others => '0');
            clk_260_800 <= '0';
        elsif clk_i'event and clk_i = '0' then 
            if mcount < conv_std_logic_vector(23,6) then
                mcount  <= mcount+1;
                clk_260_800 <= '0';
            else    
                mcount  <= (others => '0');
                clk_260_800 <= '1';
            end if;
        end if;
    end process;

    process(rstn_i, clk_i)
    begin
        if rstn_i = '0' then
            count  <= (others => '0');
            baud_o <= '0';
        elsif clk_i'event and clk_i = '0' then 
            if clk_260_800 = '1' then
                if count < BAUD_DIV-1 then
                    count  <= count+1;
                    baud_o <= '0';
                else    
                    baud_o <= clk_260_800;
                    count  <= (others => '0');
                end if;
            else
                baud_o <= '0';
            end if;
        end if;
    end process;
  

end architecture;
		
