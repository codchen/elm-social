module Profile exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias ProfileModel = {
        email: String,
        zipcode: String
    }

emptyProfile: ProfileModel
emptyProfile = {
        email = "",
        zipcode = ""
    }

-- UPDATE
type ProfileMsg = Email String
    | Zipcode String

profileUpdate: ProfileMsg -> ProfileModel -> ( ProfileModel, Cmd ProfileMsg )
profileUpdate msg model =
    case msg of
        Email email ->
            ({ model | email = email }, Cmd.batch [])
        Zipcode zipcode ->
            ({ model | zipcode = zipcode }, Cmd.batch [])

-- VIEW
profilePage: ProfileModel -> Html ProfileMsg
profilePage model =
    div [] [
        div [] [
            div [] [text "Email: "],
            div [] [text model.email]
        ],
        div [] [
            div [] [text "Zipcode: "],
            div [] [text model.zipcode]
        ]
    ]