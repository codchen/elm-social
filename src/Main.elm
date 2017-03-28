module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias MainModel = {
        headline: String
    }

emptyMain: MainModel
emptyMain = {
        headline = "hello"
    }

-- UPDATE
type MainMsg = Headline String

mainUpdate: MainMsg -> MainModel -> ( MainModel, Cmd MainMsg )
mainUpdate msg model =
    case msg of
        Headline headline ->
            ({ model | headline = headline }, Cmd.batch [])

-- VIEW
mainPage: MainModel -> Html MainMsg
mainPage model =
    div [] [
        div [] [
            div [] [text "Headline: "],
            div [] [text model.headline]
        ]
    ]