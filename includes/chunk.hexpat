import index;

#pragma endian big

struct NuccChunk<auto index> {
    u32 size;
    u32 map_index;
    u16 version;
    u16;
    if (index == 0) {
        NuccIndex data;
    } else {
    	padding[size];
    }
};
