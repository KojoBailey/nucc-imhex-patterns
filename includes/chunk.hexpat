import index;
import binary;
import texture;
import model;

import std.string;

#pragma endian big

struct NuccNull {};

struct NuccPage {
	u32 chunk_map_offset;
	u32 extra_map_offset;
};

fn format_chunk(ref auto chunk) {
	str chunk_type = std::string::substr(chunk.chunk_type, 9, std::string::length(chunk.chunk_type) - 9);
	if (chunk_type == "Null" || chunk_type == "Page")
		return chunk_type;
	return std::format("{}, {}, {}", chunk_type, chunk.file_path, chunk.chunk_name);
};

struct NuccChunk<auto index> {
	u32 size;
	u32 map_index;
	u16 version;
	u16;

	str chunk_type = get_chunk_type(index, map_index) [[export]];
	str file_path = get_file_path(index, map_index) [[export]];
	str chunk_name = get_chunk_name(index, map_index) [[export]];

	match (chunk_type) {
		("nuccChunkNull"): NuccNull data;
		("nuccChunkPage"): {
			NuccPage data;
			running_chunk_map_offset += data.chunk_map_offset;
			running_extra_map_offset += data.extra_map_offset;
		}
		("nuccChunkBinary"): NuccBinary<chunk_name> data;
		("nuccChunkTexture"): NuccTexture data;
		("nuccChunkModel"): NuccModel<version> data;
		(_): u8 data[size];
	}
} [[name(format_chunk(this))]];
