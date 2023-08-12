module Backend exposing (app)

import Env exposing (..)
import Lamdera exposing (ClientId, SessionId, broadcast, sendToFrontend)
import List exposing (append)
import Types exposing (BackendModel, BackendMsg(..), FrontendMsg(..), ToBackend(..), ToFrontend(..))


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


type alias Model =
    BackendModel


init : ( Model, Cmd BackendMsg )
init =
    ( { colorOptions =
            [ red
            , green
            , blue
            , yellow
            , rose
            ]
      , canvas = []
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        ClientConnected _ clientId ->
            ( model, sendToFrontend clientId <| CanvasNewColors model.canvas clientId )

        NoOpBackendMsg ->
            ( model, Cmd.none )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend _ clientId msg model =
    case msg of
        ColorAdded color ->
            let
                canvasWithAddedColor =
                    append model.canvas [ color ]
            in
            ( { model | canvas = canvasWithAddedColor }, broadcast (CanvasNewColors canvasWithAddedColor clientId) )

        NoOpToBackend ->
            ( model, Cmd.none )


subscriptions _ =
    Sub.batch
        [ Lamdera.onConnect ClientConnected
        ]
