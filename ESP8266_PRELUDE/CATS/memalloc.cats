#ifndef ATSLIB_PRELUDE_CATS_MEMALLOC
#define ATSLIB_PRELUDE_CATS_MEMALLOC
#include "mem.h"

void atsruntime_mfree_user (void *ptr) {
  os_free(ptr);
  return;
}
void *atsruntime_malloc_user (size_t bsz) {
  return ((void *)os_malloc(bsz));
}

#endif // ifndef ATSLIB_PRELUDE_CATS_MEMALLOC
