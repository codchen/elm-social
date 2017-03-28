port module Index exposing (..)

import Html exposing (..)
import Platform.Cmd exposing (..)

import Landing exposing (..)
import Main exposing (..)
import Profile exposing (..)

main : Program (Maybe Flags) Model Msg
main =
    Html.programWithFlags
        { 
            init = init,
            view = view,
            update = update,
            subscriptions = \_ -> Sub.none
        }

init : Maybe Flags -> ( Model, Cmd Msg )
init savedModel =
    case savedModel of
        Nothing ->
            ( { location = LandingPage,
                landing =  emptyLanding,
                main =  emptyMain,
                profile =  emptyProfile }, Cmd.batch [])
        Just flags ->
            ( { location = LandingPage,
                landing =  flags.landing,
                main =  flags.main,
                profile =  flags.profile }, Cmd.batch [])

-- MODEL
type alias Model = {
        location: Location,
        landing: LandingModel,
        main: MainModel,
        profile: ProfileModel
    }

type alias Flags = {
        landing: LandingModel,
        main: MainModel,
        profile: ProfileModel
    }

type Location = LandingPage | MainPage | ProfilePage

-- UPDATE
type Msg = NoOp
    | Landing LandingMsg
    | Main MainMsg
    | Profile ProfileMsg

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.batch [])
        Landing landingMsg ->
            let
                (landing, cmds) = landingUpdate landingMsg model.landing
            in
                ({ model | landing = landing }, Platform.Cmd.map (\cmds -> Landing cmds) cmds)
        Main mainMsg ->
            let
                (main, cmds) = mainUpdate mainMsg model.main
            in
                ({ model | main = main }, Platform.Cmd.map (\cmds -> Main cmds) cmds)
        Profile profileMsg ->
            let
                (profile, cmds) = profileUpdate profileMsg model.profile
            in
                ({ model | profile = profile }, Platform.Cmd.map (\cmds -> Profile cmds) cmds)

-- VIEW
view: Model -> Html Msg
view model =
    let
        page =
            case model.location of
                LandingPage ->
                    Html.map (\msg -> Landing msg) (landingPage model.landing)
                MainPage ->
                    Html.map (\msg -> Main msg) (mainPage model.main)
                ProfilePage ->
                    Html.map (\msg -> Profile msg) (profilePage model.profile)
    in page

