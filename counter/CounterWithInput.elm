module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


type alias Model =
    { input : Int
    , count : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 0
    , Cmd.none
    )


type Msg
    = Input String
    | Increment
    | Decrement
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model
                | count = model.count + model.input
                , input = 0
              }
            , Cmd.none
            )

        Decrement ->
            ( { model
                | count = model.count - model.input
                , input = 0
              }
            , Cmd.none
            )

        Input amount ->
            case String.toInt amount of
                Err msg ->
                    ( { model | input = 0 }, Cmd.none )

                Ok val ->
                    ( { model | input = val }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ model.count
                |> toString
                |> (++) "Count: "
                |> text
            ]
        , input
            [ type' "number"
            , placeholder "amount"
            , onInput Input
            , value
                (if model.input == 0 then
                    ""
                 else
                    toString model.input
                )
            ]
            []
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
