#pragma endian big

struct NuccModel<auto version> {
	if (version > 115 && version < 118) {
		u16;
		u16 rigging_flag;
		u16 attributes;
		padding[2];
		u32 clump_index;
		u32 hit_index;
		u32 mesh_bone_index;
		u32 size;
		nud_size = size;
		u16 light_category_flag;
		u8 render_layer;
		u8 light_mode_id;
		/* unfinished */
	} else {
		u16;
		u16 rigging_flag;
		u16 attributes;
		u8 render_layer;
		u8 light_mode_id;
		if (version > 115) {
			u32 light_category_flag;
		}
		u32 clump_index;
		u32 hit_index;
		u32 mesh_bone_index;
		u32 size;
		if (attributes & 0x04) {
			float bounding_box[6];
		}
		u8 data[size];

		u16 material_count;
		u32 material_indices[material_count];
	}
};
