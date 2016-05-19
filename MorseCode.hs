module MorseCode where

{-
Based on the following resources:

International Morse Code, Hand Sending
https://www.youtube.com/watch?v=R-petiNdCIY

Technique Of Hand Sending (1944)
https://www.youtube.com/watch?v=nVkLr0GyJPI
(2:55 showing spacing)
-}

data Element = Dot | Dash | WordSpace
type Elements = [Element]

type Code = Bool
type Codes = [Bool]

allowedChars :: [Char]
allowedChars = ' ':['A'..'Z']

isAllowedChar :: Char -> Bool
isAllowedChar = (`elem` allowedChars)

--todo simplify with: http://book.realworldhaskell.org/read/using-typeclasses.html

characterToElements :: Char -> Elements
characterToElements = undefined

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

--All signals based relative to a single beat (length of a "dot").
dot :: [Bool]
dot = replicate 1 True

dash :: [Bool]
dash = replicate 3 True

spacingBetweenElements :: [Bool]
spacingBetweenElements = replicate 1 False

spacingBetweenCharacters :: [Bool]
spacingBetweenCharacters = replicate 3 False

spacingBetweenWords :: [Bool]
spacingBetweenWords = replicate 7 False

main :: IO ()
main = do putStrLn "Morse Code application"
