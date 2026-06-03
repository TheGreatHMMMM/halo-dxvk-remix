// sharc_resolve_binding_indices.h
//
// Binding-slot constants for the SHARC resolve compute pass.
// Shared between C++ (rtx_fork_sharc.cpp descriptor writes) and Slang
// (sharc_resolve.comp.slang).
//
// Keep these in sync with the BEGIN_PARAMETER() block in SharcResolveShader
// (rtx_fork_sharc.cpp) and the resource declarations in the .comp.slang.
//
// NV-DXVK start: SHARC integration — Stage 2

#ifndef SHARC_RESOLVE_BINDING_INDICES_H
#define SHARC_RESOLVE_BINDING_INDICES_H

// ---- Inputs / UAVs ----------------------------------------------------------
// All four are read-write: the resolve pass merges accum → resolved and
// clears accum in-place.
//
// These intentionally match the Integrate Indirect SHARC binding slots.  The
// resolve pass runs between SHARC Update and SHARC Query inside the same
// dispatch path; using low slots 0-4 clobbers common raytracing descriptors
// (TLAS, surface buffers, etc.) and leaves the following Query raygen with
// invalid common resources when rtx.sharc.enableUpdate is enabled.
#define SHARC_RESOLVE_BINDING_HASH_ENTRIES   230 // RWStructuredBuffer<uint64_t>
#define SHARC_RESOLVE_BINDING_LOCK           231 // RWStructuredBuffer<uint>
#define SHARC_RESOLVE_BINDING_ACCUMULATION   232 // RWStructuredBuffer<SharcAccumulationData>
#define SHARC_RESOLVE_BINDING_RESOLVED       233 // RWStructuredBuffer<SharcPackedData>

// ---- Constant buffer --------------------------------------------------------
#define SHARC_RESOLVE_BINDING_CONSTANTS      234 // ConstantBuffer<SharcConstants>

#endif // SHARC_RESOLVE_BINDING_INDICES_H

// NV-DXVK end
