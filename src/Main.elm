module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Input as Input
import Html exposing (Html)
import List exposing (append)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { colorOptions : List String, canvas : List String }


init : Model
init =
    { colorOptions = [ "red", "green", "blue", "yellow", "rose" ]
    , canvas = []
    }



-- UPDATE


type Msg
    = NoOp
    | AddColor String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        AddColor color ->
            { model | canvas = append model.canvas [ color ] }



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout
        []
    <|
        column
            [ spacing 10, padding 10 ]
            [ wrappedRow [ spacing 10 ] (List.map (\color -> column [] [ text color ]) model.canvas)
            , row
                [ spacing 10
                ]
                (List.map
                    (\color ->
                        Input.button
                            []
                            { onPress = Just (AddColor color), label = text color }
                    )
                    model.colorOptions
                )
            ]
