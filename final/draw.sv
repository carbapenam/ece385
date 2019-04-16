always_comb
 
begin: sprite_address_arbitor
 
case(which_sprite_to_draw)
 
DRAW_TOAD: //toad
 
begin
 
//32 is distance from the center to left edge
 
//of this sprite. i.e. the half-width
 
sprite_x = drawx-toadX+32;
 
sprite_y = drawy-toadY+32;
 
end
 
DRAW_BIRD:
 
begin
 
sprite_x = drawx+progress-BirdX+32;
 
sprite_y = drawy-BirdY+32;
 
end


DRAW_BIRD: begin
 
unique case (bird_animation)
 
1'b0:
 
begin
 
SRAM_addr = (sprite_x + 320 + ((sprite_y+128) <> 1;
 
end
 
1'b1:
 
begin
 
SRAM_addr = (sprite_x + 384 + ((sprite_y+128) <> 1;
 
end
 
default: ;
 
endcase
 
end