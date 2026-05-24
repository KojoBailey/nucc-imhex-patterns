import std.mem;
import std.string;

using NullString = std::string::NullString;

#pragma endian big

struct ChunkMap {
	u32 chunk_type_index;
	u32 file_path_index;
	u32 chunk_name_index;
};

struct ExtraMap {
	u32 chunk_name_index;
	u32 chunk_map_index;
};

struct NuccIndex {
	u32 size [[hidden]];
	u32 map_index [[hidden]];
	u16 version [[hidden]];
	u16 [[hidden]];

	u32 chunk_type_count;
	u32 chunk_type_size;
	u32 file_path_count;
	u32 file_path_size;
	u32 chunk_name_count;
	u32 chunk_name_size;
	u32 chunk_map_count;
	u32 chunk_map_size;
	u32 chunk_map_indices_count;
	u32 extra_map_indices_count;

	NullString chunk_types[chunk_type_count];
	NullString file_paths[file_path_count];
	NullString chunk_names[chunk_name_count];

	std::mem::AlignTo<4>;

	ChunkMap chunk_maps[chunk_map_count];
	ExtraMap extra_map_indices[extra_map_indices_count];
	u32 chunk_map_indices[chunk_map_indices_count];
};

fn get_chunk_type(ref auto index, u32 map_index) {
	return index.chunk_types[index.chunk_maps[map_index].chunk_type_index];
};

fn get_chunk_name(ref auto index, u32 map_index) {
	return index.chunk_names[index.chunk_maps[map_index].chunk_name_index];
};
