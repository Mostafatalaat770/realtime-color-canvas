module Types exposing (..)

import Element exposing (Color)
import Lamdera exposing (ClientId, SessionId)


type alias Color =
    { red : Float, green : Float, blue : Float, alpha : Float }


type alias FrontendModel =
    { colorOptions : List Color, canvas : List Color, clientId : String }


type alias BackendModel =
    { colorOptions : List Color, canvas : List Color }


type FrontendMsg
    = AddColor Color
    | ResetCanvas
    | NoOpFrontendMsg


type ToBackend
    = ColorAdded Color
    | CanvasHasBeenReset
    | NoOpToBackend


type BackendMsg
    = ClientConnected SessionId ClientId
    | NoOpBackendMsg


type ToFrontend
    = CanvasNewColors (List Color) String
    | NoOpToFrontend
