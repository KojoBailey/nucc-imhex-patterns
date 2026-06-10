import player_color_param;

#pragma endian big

struct NuccBinary<auto chunk_name> {
	u32 size;

	match (chunk_name) {
		("PlayerColorParam"): PlayerColorParam data;
		(_): {
			u8 data[size];
		}
	}
};

