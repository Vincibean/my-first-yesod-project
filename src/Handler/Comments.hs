{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Comments where

import Import
import Data.Time
import Yesod.Auth

makeComment :: PostId -> Text -> UserId -> UTCTime -> Comment
makeComment post body = \author time -> Comment post author time body

commentForm :: PostId -> Form (UserId -> UTCTime -> Comment)
commentForm post = renderDivs $ makeComment post
                   <$> areq textField "Comment" Nothing

postCommentsR :: PostId -> Handler Html
postCommentsR post = do
    authorId <- requireAuthId
    ((result, _), _) <- runFormPost $ commentForm post
    case result of
        FormSuccess mkComment -> do
            time <- liftIO getCurrentTime
            _ <- runDB $ insert $ mkComment authorId time
            redirect $ PostR post
        _ -> defaultLayout [whamlet|whoops|]
