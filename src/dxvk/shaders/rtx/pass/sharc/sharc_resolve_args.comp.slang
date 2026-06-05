/*
 * Copyright (c) 2026, Remix Plus contributors. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include "sharc_constants.h"
#include "sharc_resolve_binding_indices.h"

layout(binding = SHARC_RESOLVE_BINDING_CONSTANTS)
ConstantBuffer<SharcConstants> sharcCb;

layout(binding = SHARC_RESOLVE_BINDING_ACTIVE_COUNTS)
RWStructuredBuffer<uint> u_ActiveCounts;

layout(binding = SHARC_RESOLVE_BINDING_DISPATCH_ARGS)
RWStructuredBuffer<uint> u_DispatchArgs;

[shader("compute")]
[numthreads(1, 1, 1)]
void main(uint3 threadId : SV_DispatchThreadID)
{
  const uint activeCount = min(u_ActiveCounts[uint(sharcCb.activeListReadIndex)], uint(sharcCb.capacity));

  // VkDispatchIndirectCommand { uint32_t x, y, z }.
  u_DispatchArgs[0] = (activeCount + 255u) / 256u;
  u_DispatchArgs[1] = 1u;
  u_DispatchArgs[2] = 1u;
}