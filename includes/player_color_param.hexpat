struct String<auto length> {
	char string[length];
} [[inline]];

struct RGB {
	le u32 red;
	le u32 green;
	le u32 blue;
};

struct PlayerColorParamEntry {
	le u64 pointer;
	le u32 costume_index;
	RGB color;
};

struct PlayerColorParam {
	le u32 version;
	le u32 entry_count;
	le u64 note_pointer;

	PlayerColorParamEntry entries[entry_count];
	String<8> character_id[entry_count];
};

