
module MonadsDo where


--Her brukes den ordentlige Monad-classen i standardbiblioteket. 
-- Den er helt lik, utenom at den bruker >>= (uttales bind), som er en flippet andThen
-- Det skal ikke påvirke oppgaveløsningen
-- class Functor f => Monad m where
--     (>>=) :: m a -> (a -> m b) -> m b
--     return :: a -> m a

andThen :: Monad m => (a -> m b) -> m a -> m b
andThen = flip (>>=)

-- | skriv map3 med do-notation. Bonus : uten do-notation
-- >>> map3 (\x y z -> x+y+z) (Just 3) (Just 3) (Just 3)
-- Just 9
map3 :: Monad m => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
map3 f ma mb mc = do
    a <- ma
    b <- mb
    c <- mc
    return (f a b c)

map3AndThen :: Monad m => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
map3AndThen f ma mb mc = 
    andThen (\a ->
        andThen (\b ->
            andThen (\c ->
                return (f a b c)) mc) mb) ma

-- skriv andMap med do-notation
andMap :: Monad m => m (a -> b) -> m a -> m b
andMap mab ma = do
    f <- mab
    a <- ma
    return (f a)



-- | få list1233 til å bli som i testen, ved å bytte ut  de to første undefined med Functor/Monad-funksjoner 
-- | og den siste med en liste
-- >>> list1233
-- [(1,2,3),(1,2,3)]
list1233 :: [(Int,Int,Int)]
list1233 = do
    one <- return 1
    two <- andThen (\x -> [x,x]) [2]
    three <- fmap (+1) [2]
    return (one,two,three) 


-- | Hva blir resultatet av de forskjellige uttrykene? prøv å evaluer i hodet før du sjekker i repl
-- Det kan kanskje hjelpe å skrive om til do-notation eller and-then
--
-- Just 2 >> Just 3 blir Just 3
--
-- Nothing >> Just 3 blir Nothing
--
-- Just 4 >> Nothing blir Nothing
--
-- [1,2,3] >> ["2","2"] blir ["2","2","2","2","2","2"]
--
-- ["2","2"] >> [1,2,3] blir [1,2,3,1,2,3]
