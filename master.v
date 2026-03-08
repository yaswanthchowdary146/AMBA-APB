`include"slave.v"
module master;

    reg pclk,presetn,penable,pwrite,psel;
    reg [4:0] paddr;
    reg [31:0] pwdata;
    wire [31:0] prdata;
    wire pready,pslverr;

    slave dut (pwdata,paddr,prdata,psel,pclk,presetn,penable,pwrite,pready,pslverr);

    // Clock generation
    initial begin
        pclk=0;
        forever #5 pclk=~pclk;
    end

// Reset task
    task rst;
    begin
        psel=0;
        pwdata=0;
        paddr=0;
        penable=0;
        pwrite=0;

        presetn=0;
        @(posedge pclk);
        presetn=1;
    end
    endtask

// Write task
    task write;
    begin
        @(posedge pclk);
        psel=1;
        pwrite=1;
        paddr=5'd20;
        pwdata=32'ha5b3c677;
        penable=0;

        @(posedge pclk);
        penable=1;

        @(posedge pclk);   
	@(posedge pclk);   
        psel=0;
        penable=0;

        // second write
        @(posedge pclk);
        psel=1;
        pwrite=1;
        paddr=5'd10;
        pwdata=32'hffaabb12;
        penable=0;

        @(posedge pclk);
        penable=1;

        @(posedge pclk);
        @(posedge pclk);   
        psel=0;
        penable=0;
    end
    endtask


// Read task
    task read;
    begin
        @(posedge pclk);
        psel=1;
        pwrite=0;
        paddr=5'd20;
        penable=0;

        @(posedge pclk);
        penable=1;

        @(posedge pclk);
        @(posedge pclk);   
        psel=0;
        penable=0;

        // second read
        @(posedge pclk);
        psel=1;
        paddr=5'd10;
        penable=0;

        @(posedge pclk);
        penable=1;

        @(posedge pclk);
        @(posedge pclk);  
        psel=0;
        penable=0;
    end
    endtask


// Monitor
    initial begin
        $monitor("presetn=%b | penable=%b | psel=%b | pwrite=%b | paddr=%d | pwdata=%h | prdata=%h | pready=%b",
        presetn,penable,psel,pwrite,paddr,pwdata,prdata,pready);
    end

// Test
    initial begin
        rst;
        write;
        read;
        #50;
        $finish;
    end

endmodule
	

