{-# LANGUAGE OverloadedStrings #-}
module Handler.HelloSpec (spec) where

import TestImport

spec :: Spec
spec = withApp $ do

    describe "getHelloR" $ do
        it "loads the hello world page and checks it looks right" $ do
            get HelloR
            statusIs 200
            bodyContains "Hello World!"

