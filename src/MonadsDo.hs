
module Monadsdo where



andThen :: Monad m => (a -> m b) -> m a -> m b
andThen = flip (>>=)

-- | skriv map3 med do-notation. Bonus : uten do-notation
-- >>> map3 (\x y z -> x+y+z) (Just 3) (Just 3) (Just 3)
-- Just 9
map3 :: Monad m => (a -> b -> c -> d) -> m a -> m b -> m c
map3 = error "todo map3"



-- | få list1233 til å bli som i testen, ved å bytte ut  de to første undefined med Functor/Monad-funksjoner 
-- | og den siste med en liste
-- >>> list1233
-- [(1,2,3),(1,2,3)]
list1233 :: [(Int,Int,Int)]
list1233 = do
    one <- undefined 1
    two <- undefined (+1) 2
    three <- undefined
    return (one,two,three) 