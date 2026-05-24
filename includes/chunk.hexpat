import index;
import binary;

#pragma endian big

struct NuccNull {};

struct NuccPage {
	u32 chunk_map_offset;
	u32 extra_map_offset;
};

struct NuccChunk<auto index> {
	u32 size;
	u32 map_index;
	u16 version;
	u16;

	match (get_chunk_type(index, map_index)) {
		("nuccChunkNull"): NuccNull data;
		("nuccChunkPage"): NuccPage data;
		("nuccChunkBinary"): NuccBinary<get_chunk_name(index, map_index)> data;
	}
};
