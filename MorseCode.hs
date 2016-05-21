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
import Data.Char (toUpper)

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
characterToElements x = spaceOut $ simpleNoSpace (toUpper x)
  where
    spaceOut = intersperse InterCodeSpace
    simpleNoSpace c
        | c == ' ' = [InterWordSpace]
        | c == 'A' = [Dot,Dash]
        | c == 'B' = [Dash,Dot,Dot,Dot]
        | c == 'C' = [Dash,Dot,Dash,Dot]
        | c == 'D' = [Dash,Dot,Dot]
        | c == 'E' = [Dot]
        | c == 'F' = [Dot,Dot,Dash,Dot]
        | c == 'G' = [Dash,Dash,Dot]
        | c == 'H' = [Dot,Dot,Dot,Dot]
        | c == 'I' = [Dot,Dot]
        | c == 'J' = [Dot,Dash,Dash,Dash]
        | c == 'K' = [Dash,Dot,Dash]
        | c == 'L' = [Dot,Dash,Dot,Dot]
        | c == 'M' = [Dash,Dash]
        | c == 'N' = [Dash,Dot]
        | c == 'O' = [Dot,Dot,Dot]
        | c == 'P' = [Dot,Dash,Dash,Dot]
        | c == 'Q' = [Dash,Dash,Dot,Dash]
        | c == 'R' = [Dot,Dash,Dot]
        | c == 'S' = [Dash,Dash,Dash]
        | c == 'T' = [Dash]
        | c == 'U' = [Dot,Dot,Dash]
        | c == 'V' = [Dot,Dot,Dot,Dash]
        | c == 'W' = [Dot,Dash,Dash]
        | c == 'X' = [Dash,Dot,Dot,Dash]
        | c == 'Y' = [Dash,Dot,Dash,Dash]
        | c == 'Z' = [Dash,Dash,Dot,Dot]
        | c == '1' = [Dot,Dash,Dash,Dash,Dash]
        | c == '2' = [Dot,Dot,Dash,Dash,Dash]
        | c == '3' = [Dot,Dot,Dot,Dash,Dash]
        | c == '4' = [Dot,Dot,Dot,Dot,Dash]
        | c == '5' = [Dot,Dot,Dot,Dot,Dot]
        | c == '6' = [Dash,Dot,Dot,Dot,Dot]
        | c == '7' = [Dash,Dash,Dot,Dot,Dot]
        | c == '8' = [Dash,Dash,Dash,Dot,Dot]
        | c == '9' = [Dash,Dash,Dash,Dash,Dot]
        | c == '0' = [Dash,Dash,Dash,Dash,Dash]
        | otherwise = error $ "Char is not defined in terms of Elements: " ++ [x]

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
charactersToElements = concat . (intersperse [InterCharSpace]) . (map characterToElements)

elementsToMessage :: Elements -> String
elementsToMessage = map elementToCharacter

messageToCodes :: String -> Codes
messageToCodes = concat . (map elementToCodes) . charactersToElements

main :: IO ()
main = do
    putStrLn "Morse Code application:"
    putStrLn $ message
    print $ charactersToElements message
    print $ messageToCodes message
  where
    message = "SOS"
