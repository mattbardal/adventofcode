import Data.Char (isDigit)

-- first attempt
p1 :: FilePath -> IO ()
p1 path =
    readFile path >>=
    \input ->
        let lines = split '\n' input in
        let digits = map (filter isDigit) lines in
        let numbers = map getFirstAndLastDigit digits in
            print (sum numbers)


-- second attempt
p1' :: FilePath -> IO ()
p1' path = do
    input <- readFile path
    let numbers = map (getFirstAndLastDigit . filter isDigit) (split '\n' input) in
        print (sum numbers)

-- helpers

split :: Char -> String -> [String]
split _ [] = []
split x xs = let (prefix, suffix) = break (== x) xs
                in prefix : split x (drop 1 suffix)

getFirstAndLastDigit :: String -> Int
getFirstAndLastDigit [] = 0
getFirstAndLastDigit [x] = read [x,x] :: Int
getFirstAndLastDigit (x:xs) =  read (head (x:xs) : [last xs]) :: Int
