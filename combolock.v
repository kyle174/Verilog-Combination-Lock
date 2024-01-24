module combolock(Clock, Resetn, password, enter, change, leds, enterpulse, changepulse, correct);
	input Clock, Resetn, enter, change;
	input [3:0] password;
	output reg [0:6] leds;
	output wire enterpulse, changepulse;
	output reg correct;
	
	reg [3:1] y, Y = 3'b000;
	reg [3:0] combo = 4'b0110;
	reg [3:0] temp = 4'b0110;
	parameter [3:1] START = 3'b000, NEW = 3'b001, WRONG = 3'b010, ALARM = 3'b011, OPEN = 3'b100;
	
	inputcond entercond(Clock, enter, enterpulse);
	inputcond changecond(Clock, change, changepulse);
	
	always @(password, combo) begin
		if (password == combo) correct = 1;
		else						correct = 0;
	end
	
	always @(enter, change) begin
		case (y)
			START: begin
				combo=temp;
				if (changepulse & correct) Y = NEW;
				else if (enterpulse & correct) Y = OPEN;
				else if ((changepulse & !correct)|(enterpulse & !correct)) Y = WRONG;
				else Y = START;
				end
			
			NEW: begin
				if (changepulse || enterpulse) 
				begin
					combo = password;
					Y = START;
				end 
				else Y = NEW;
				end
				
			WRONG: begin
				if (changepulse & correct) Y = NEW;
				else if (enterpulse & correct) Y = OPEN;
				else if ((changepulse & !correct)|(enterpulse & !correct)) Y = ALARM;
				else Y = WRONG;
				end
				
			ALARM: ;
			
			OPEN: if (enterpulse) Y = START;
			
			default: Y = 3'bxxx;
		endcase
	end
	
	always @(posedge Clock, negedge Resetn) begin
		if (Resetn == 0)
		begin
		y <= START;
		temp = 4'b0110;
		end
		
		else
		begin
		y <= Y;
		temp = combo;
		end
	end
	
	always @(y) begin
		case (y)
			NEW: leds = 7'b1101010;
			ALARM: leds = 7'b0001000;
			OPEN: leds = 7'b0000001;
			default: leds = 7'b1111110;
		endcase
	end
	
endmodule
