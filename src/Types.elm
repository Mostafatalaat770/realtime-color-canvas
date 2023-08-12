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
    = NoOpFrontendMsg
    | AddColor Color


type ToBackend
    = NoOpToBackend
    | ColorAdded Color


type BackendMsg
    = ClientConnected SessionId ClientId
    | NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
    | CanvasNewColors (List Color) String
