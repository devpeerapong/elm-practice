module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.App as App


-- Model


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    Html.div []
        [ model
            |> toString
            |> Html.text
        , br [] []
        , button
            [ type' "button"
            , onClick Increment
            ]
            [ text "+" ]
        , button
            [ type' "button"
            , onClick Decrement
            ]
            [ text "-" ]
        ]



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- Message


type Msg
    = Increment
    | Decrement
    | NoOp



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
