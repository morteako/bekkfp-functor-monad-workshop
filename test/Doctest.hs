import Test.DocTest (doctest)

main :: IO ()
main = do
  doctest ["-isrc", "src"]