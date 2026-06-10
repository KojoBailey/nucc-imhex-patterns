import std.mem;
import std.string;

using NullString = std::string::NullString;

#pragma endian big

u32 running_chunk_map_offset = 0;
u32 running_extra_map_offset = 0;

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
	u32 true_map_index = index.chunk_map_indices[map_index + running_chunk_map_offset];
	u32 type_index = index.chunk_maps[true_map_index].chunk_type_index;
	return index.chunk_types[type_index];
};

fn get_file_path(ref auto index, u32 map_index) {
	u32 true_map_index = index.chunk_map_indices[map_index + running_chunk_map_offset];
	u32 path_index = index.chunk_maps[true_map_index].file_path_index;
	return index.file_paths[path_index];
};

fn get_chunk_name(ref auto index, u32 map_index) {
	u32 true_map_index = index.chunk_map_indices[map_index + running_chunk_map_offset];
	u32 name_index = index.chunk_maps[true_map_index].chunk_name_index;
	return index.chunk_names[name_index];
};
