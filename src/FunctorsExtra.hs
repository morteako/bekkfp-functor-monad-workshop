module FunctorsExtra where

-- | puts a value into the functor
-- >>> setValue 1 Nothing
-- Nothing
-- >>> setValue 1 (Just "hei")
-- Just 1

-- >>> setValue "a" [True,False]
-- ["a","a"]
setValue :: Functor f => a -> f b -> f a
setValue = undefined

data State s a = State (s -> (a, s))

instance Functor (State s) where
  fmap = undefined
