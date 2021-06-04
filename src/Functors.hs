{-# LANGUAGE KindSignatures #-}

module Functors where

import Prelude hiding (fmap, map)

-- | Compute Fibonacci numbers
-- >>> fib 5
-- 30
fib :: Int -> Int
fib = id

-- class MyFunctor (f :: * -> *) where
--   fmap :: (a -> b) -> f a -> f b

-- class MyFunctor2 f where
--   fmap2 :: (a -> b) -> f a -> f b

-- instance MyFunctor Maybe where
--   fmap f Nothing = Nothing
--   fmap f (Just x) = Just (f x)

-- instance MyFunctor (Either a) where
--   fmap = undefined