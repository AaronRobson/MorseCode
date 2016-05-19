module MorseCode where

{-
Based on the following resources:

International Morse Code, Hand Sending
https://www.youtube.com/watch?v=R-petiNdCIY

Technique Of Hand Sending (1944)
https://www.youtube.com/watch?v=nVkLr0GyJPI
(2:55 showing spacing)
-}

import Data.List (intersperse)

data Element = Dot | Dash | InterCodeSpace | InterCharSpace | InterWordSpace
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
characterToElements 'O' = intersperse InterCodeSpace [Dot,Dot,Dot]
characterToElements 'S' = intersperse InterCodeSpace [Dash,Dash,Dash]
characterToElements x = error $ "Char is not defined in terms of Elements: " ++ [x]

--All signals based relative to a single beat (length of a "dot").
dot :: Codes
dot = replicate 1 True

dash :: Codes
dash = replicate 3 True

spacingInterElement :: Codes
spacingInterElement = replicate 1 False

spacingInterChar :: Codes
spacingInterChar = replicate 3 False

spacingInterWord :: Codes
spacingInterWord = replicate 7 False

elementToCharacter :: Element -> Char
elementToCharacter = undefined

elementToCodes :: Element -> Codes
elementToCodes Dot = dot
elementToCodes Dash = dash
elementToCodes InterCodeSpace = spacingInterElement
elementToCodes InterCharSpace = spacingInterChar
elementToCodes InterWordSpace = spacingInterWord

codeToElement :: Code -> Element
codeToElement = undefined

--Based on the above.

characterToCodes :: Char -> Codes
characterToCodes = concat . (map elementToCodes) . characterToElements

codeToCharacter :: Code -> Char
codeToCharacter = elementToCharacter . codeToElement

--Helper functions for lists of the units.

charactersToElements :: String -> Elements
charactersToElements = concat . (map characterToElements)

elementsToMessage :: Elements -> String
elementsToMessage = map elementToCharacter

messageToCodes :: String -> Codes
messageToCodes = concat . (map characterToCodes)

main :: IO ()
main = do
    putStrLn "Morse Code application:"
    putStrLn $ message
    print $ charactersToElements message
    print $ messageToCodes message
  where
    message = "SOS"
