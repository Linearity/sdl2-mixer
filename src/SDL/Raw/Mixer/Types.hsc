{-# LANGUAGE DeriveDataTypeable #-}
module SDL.Raw.Mixer.Types (
  Chunk(..)
) where

#include "SDL_Mixer.h"

import Data.Typeable
import Data.Word
import Foreign.C.Types
import Foreign.Ptr
import Foreign.Storable

data Chunk = Chunk
  { chunkAllocated :: CInt
  , chunkAbuf :: Ptr Word8
  , chunkAlen :: Word32
  , chunkVolume :: Word8
  } deriving (Eq, Show, Typeable)

instance Storable Chunk where
  sizeOf _ = (#size Mix_Chunk)
  alignment = sizeOf
  peek ptr = do
    allocated <- (#peek Mix_Chunk, allocated) ptr
    abuf <- (#peek Mix_Chunk, abuf) ptr
    alen <- (#peek Mix_Chunk, alen) ptr
    volume <- (#peek Mix_Chunk, volume) ptr
    return $! Chunk allocated abuf alen volume
  poke ptr (Chunk allocated abuf alen volume) = do
    (#poke Mix_Chunk, allocated) ptr allocated
    (#poke Mix_Chunk, abuf) ptr abuf
    (#poke Mix_Chunk, alen) ptr alen
    (#poke Mix_Chunk, volume) ptr volume
