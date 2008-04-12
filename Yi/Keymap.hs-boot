-- -*- haskell -*-

module Yi.Keymap where

import qualified Yi.Interact as I
import Yi.Event

data Action

type Interact ev a = I.I ev Action a

type KeymapM a = Interact Event a

type Keymap = KeymapM ()

type KeymapEndo = Keymap -> Keymap
