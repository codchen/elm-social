module Landing exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias LandingModel = {
        username: String,
        password: String,
        logged: Bool
    }

emptyLanding: LandingModel
emptyLanding = {
        username = "",
        password = "",
        logged = False
    }

-- UPDATE
type LandingMsg = LogInRequest
    | Username String
    | Password String

landingUpdate: LandingMsg -> LandingModel -> ( LandingModel, Cmd LandingMsg )
landingUpdate msg model =
    case msg of
        LogInRequest ->
            ({ model | logged = True }, Cmd.batch [])
        Username username ->
            ({ model | username = username }, Cmd.batch [])
        Password password ->
            ({ model | password = password }, Cmd.batch [])

-- VIEW
landingPage: LandingModel -> Html LandingMsg
landingPage model =
    div [] [
        input [type_ "text", placeholder "Username", onInput Username] [],
        input [type_ "password", placeholder "Password", onInput Password] [],
        button [onClick LogInRequest] [text "Log in"]
    ]