{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}

-- | Utilities for working with new Control.Exception
module Control.Exc (ignoringException, printingException, orException)
where

#if defined(__GLASGOW_HASKELL__) && (__GLASGOW_HASKELL__ >= 706)
import Prelude
#else
import Prelude hiding (catch)
#endif
import Control.Exception (catch, SomeException)

-- | Execute IO (Maybe a) action replacing all exceptions with return value of Nothing.
ignoringException :: IO (Maybe a) -> IO (Maybe a)
ignoringException f = f `catch` ignore
  where ignore (_ :: SomeException) = return Nothing

-- | Execute IO () action, replacing all exceptions with messages
printingException :: [Char] -> IO a -> IO a
printingException desc f = f `catch` handler
  where handler (err :: SomeException) = fail $ concat [desc, " failed: ", show err]

-- | Execute IO () action, replacing all exceptions with messages
orException :: IO a -> IO a -> IO a
orException f g = f `catch` handler
  where handler (_ :: SomeException) = g
