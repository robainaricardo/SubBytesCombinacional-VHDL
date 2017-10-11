library verilog;
use verilog.vl_types.all;
entity SubBytesLP is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enableS         : in     vl_logic;
        blocoIn         : in     vl_logic_vector(0 to 127);
        blocoOut        : out    vl_logic_vector(0 to 127)
    );
end SubBytesLP;
