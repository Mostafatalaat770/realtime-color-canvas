module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background
import Element.Border
import Element.Input as Input
import Html exposing (Html)
import List exposing (append)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


red =
    Element.rgb 255 0 0


green =
    Element.rgb 0 255 0


blue =
    Element.rgb 0 0 255


yellow =
    Element.rgb 255 255 0


rose =
    Element.rgb 255 0 255


type alias Model =
    { colorOptions : List Color, canvas : List Color }


init : Model
init =
    { colorOptions = [ red, green, blue, yellow, rose ]
    , canvas = []
    }



-- UPDATE


type Msg
    = NoOp
    | AddColor Color


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
            [ wrappedRow [ spacing 10 ]
                (List.map
                    (\color ->
                        el
                            [ width (px 50)
                            , height (px 50)
                            , Element.Border.rounded 50
                            , Element.Background.color color
                            ]
                            (text "")
                    )
                    model.canvas
                )
            , row
                [ spacing 10
                ]
                (List.map
                    (\color ->
                        Input.button
                            [ width (px 50)
                            , height (px 50)
                            , Element.Border.rounded 50
                            , Element.Background.color color
                            ]
                            { onPress = Just (AddColor color), label = text "" }
                    )
                    model.colorOptions
                )
            ]
