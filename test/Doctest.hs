import Test.DocTest (doctest)

main :: IO ()
main = do
  doctest ["-isrc", "src/Intro.hs"]
  doctest ["-isrc", "src/Functors.hs"]
  doctest ["-isrc", "src/FunctorsExtra.hs"]
  doctest ["-isrc", "src/Monads.hs"]
  doctest ["-isrc", "src/MonadsDo.hs"]
  doctest ["-isrc", "src/MonadsExtra.hs"]
  return ()