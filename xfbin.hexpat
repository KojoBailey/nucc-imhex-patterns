#pragma endian big

struct NuccChunk<T> {
    u32 size;
    u32 map_index;
    u16 version;
    u16 unk;
    T data;
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
};

struct Xfbin {
    char file_signature[4];
    u32 version;
    padding[2];
    char language_id[2];
    padding[2] [[comment("Something to do with encryption.")]];
    padding[2];
    NuccChunk<NuccIndex> index;
};

Xfbin xfbin @ 0x00 [[inline]];