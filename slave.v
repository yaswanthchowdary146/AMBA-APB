module slave(input [31:0]pwdata,
	input [4:0] paddr,
	output  reg [31:0] prdata,
	input psel,pclk,presetn,
	penable,
	pwrite,
	output reg pready,pslverr);

reg [31:0] mem [31:0];
integer i;

localparam IDLE=2'd0,
	SETUP=2'd1,
	ACCESS=2'd2;

reg [1:0] ps,ns;

always @ (posedge pclk or negedge presetn) begin
	if(!presetn) begin
		ps<=IDLE;
		prdata<=0;
		pready<=0;
		pslverr<=0;
		for (i=0;i<32;i=i+1) 
			mem[i]<=32'b0;
	end
	else begin
		ps<=ns;

		pready<=0;
		pslverr<=0;

		if(ps==ACCESS && psel && penable) begin
			pready<=1;

			if(paddr<32) begin
				if(pwrite)
					mem[paddr] <= pwdata;
				else
					prdata <= mem[paddr];
			end
			else
				pslverr<=1;
		end
	end
end


always  @ (*) begin
	case(ps)
		IDLE: begin 
		if(psel && !penable)
			ns=SETUP;
		else
			ns=IDLE;
	end

	SETUP: begin 
	if (psel && penable)
		ns=ACCESS;
	else
		ns=SETUP;
end

ACCESS: begin
	if (!psel)
		ns = IDLE;
	else
		ns = ACCESS;
end

default: ns = IDLE;              
	  endcase
  end

  endmodule
