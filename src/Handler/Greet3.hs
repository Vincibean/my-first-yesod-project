{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Greet3 where

import           Import

getGreet3R :: Handler Html
getGreet3R = do
    name <- newIdent
    defaultLayout $(widgetFile "greet3")
     where color = "blue" :: Text