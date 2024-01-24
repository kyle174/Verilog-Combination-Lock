module inputcond(Clock, a, pulse);

input Clock, a;
output pulse;
reg [1:0] y, Y;
parameter A = 2'b00, B = 2'b01, C = 2'b10;

always @(a, y)
begin
	case (y)
		A: if (a == 0) Y = B;
			else Y = A;
		B: if (a == 0) Y = C;
			else Y = A;
		C: if (a == 0) Y = C;
			else Y = A;
		default: Y = 2'bxx;
	endcase
end

always @(posedge Clock)
begin
	y <= Y;
end

assign pulse = (y == B);

endmodule