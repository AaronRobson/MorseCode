module MorseCode where

{-
Based on the following resources:

International Morse Code, Hand Sending
https://www.youtube.com/watch?v=R-petiNdCIY

Technique Of Hand Sending (1944)
https://www.youtube.com/watch?v=nVkLr0GyJPI
(2:55 showing spacing)
-}

data Element = Dot | Dash | IntraWordSpace | InterWordSpace
  deriving (Eq, Show)
type Elements = [Element]

type Code = Bool
type Codes = [Bool]

allowedChars :: [Char]
allowedChars = ' ':['A'..'Z']

isAllowedChar :: Char -> Bool
isAllowedChar = (`elem` allowedChars)

--todo simplify with: http://book.realworldhaskell.org/read/using-typeclasses.html

characterToElements :: Char -> Elements
characterToElements ' ' = [InterWordSpace]
characterToElements 'O' = [Dot,Dot,Dot]
characterToElements 'S' = [Dash,Dash,Dash]

--All signals based relative to a single beat (length of a "dot").
dot :: [Bool]
dot = replicate 1 True

dash :: [Bool]
dash = replicate 3 True

spacingInterElement :: [Bool]
spacingInterElement = replicate 1 False

spacingInterChar :: [Bool]
spacingInterChar = replicate 3 False

spacingInterWord :: [Bool]
spacingInterWord = replicate 7 False

elementToCharacter :: Element -> Char
elementToCharacter = undefined

elementToCode :: Element -> Code
elementToCode = undefined

codeToElement :: Code -> Element
codeToElement = undefined

--Based on the above.

characterToCodes :: Char -> Codes
characterToCodes = (map elementToCode) . characterToElements

codeToCharacter :: Code -> Char
codeToCharacter = elementToCharacter . codeToElement

--Helper functions for lists of the units.

charactersToElements :: String -> Elements
charactersToElements = concat . (map characterToElements)

elementsToMessage :: Elements -> String
elementsToMessage = map elementToCharacter

main :: IO ()
main = do
    putStrLn "Morse Code application:"
    putStrLn $ message
    print $ charactersToElements message
  where
    message = "SOS"
