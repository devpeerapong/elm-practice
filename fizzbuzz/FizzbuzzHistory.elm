module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


type alias Model =
    { input : Int
    , condition : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 [], Cmd.none )


type Msg
    = OnInput String
    | Calculate


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput val ->
            case String.toInt val of
                Err msg ->
                    ( model, Cmd.none )

                Ok val ->
                    let
                        newModel =
                            { model
                                | input = val
                            }
                    in
                        ( newModel, Cmd.none )

        Calculate ->
            let
                con =
                    calFizzBuzz model.input

                newModel =
                    { model
                        | condition = model.condition ++ [ con ]
                        , input = 0
                    }
            in
                ( newModel, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ counterInput model
        , button
            [ type' "button"
            , onClick Calculate
            ]
            [ text "calculate" ]
        , model.condition
            |> List.map (\history -> historyItem history)
            |> h3 []
        ]


historyItem : String -> Html Msg
historyItem history =
    h3 []
        [ text history ]


counterInput : Model -> Html Msg
counterInput model =
    div []
        [ input
            [ type' "number"
            , onInput OnInput
            , value
                (if model.input == 0 then
                    ""
                 else
                    toString model.input
                )
            ]
            []
        ]


calFizzBuzz : Int -> String
calFizzBuzz num =
    if fizzbuzz num then
        "FizzBuzz"
    else if fizz num then
        "Fizz"
    else if buzz num then
        "Buzz"
    else
        ""


fizzbuzz : Int -> Bool
fizzbuzz num =
    (num % 5 == 0) && (num % 3 == 0)


fizz : Int -> Bool
fizz num =
    num % 3 == 0


buzz : Int -> Bool
buzz num =
    num % 5 == 0


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
