{-# LANGUAGE KindSignatures #-}

module Functors where

import Prelude hiding (fmap, map)

-- | Compute Fibonacci numbers
-- >>> fib 5
-- 30
fib :: Int -> Int
fib = id

class MyFunctor (f :: * -> *) where
  map :: (a -> b) -> f a -> f b

instance MyFunctor Maybe where
  map f Nothing = Nothing
  map f (Just x) = Just (f x)