{-# LANGUAGE QuasiQuotes           #-}

module Handler.Hello where

import Import

getHelloR :: Handler Html
getHelloR = defaultLayout [whamlet|Hello World!|]
