import std.mem;
import std.string;
import std.sys;

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

struct NuccChunk<auto index> {
    u32 size;
    u32 map_index;
    u16 version;
    u16;
    if (index == 0) {
        NuccIndex data;
    }
};

struct Flags {
    u16;
    char language_id[2];
    u16 [[comment("Something to do with encryption.")]];
    u16;
};

char file_signature[4] @ 0x00;
std::assert(file_signature == "NUCC",
    "Mismatched file signature: Expected `NUCC`.");
u32 version @ $;
Flags flags @ $;
 
for (u32 i = 0, /*!std::mem::eof()*/ i < 1, i += 1) {
    NuccChunk<i> index @ $;
}