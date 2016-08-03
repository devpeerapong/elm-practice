module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


type alias Model =
    { input : Int
    , condition : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 "", Cmd.none )


type Msg
    = OnInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput val ->
            case String.toInt val of
                Err msg ->
                    ( model, Cmd.none )

                Ok val ->
                    let
                        con =
                            calFizzBuzz val
                    in
                        ( { model
                            | condition = con
                          }
                        , Cmd.none
                        )


view : Model -> Html Msg
view model =
    div []
        [ counterInput model
        , h3 []
            [ text <| model.condition ]
        ]


counterInput : Model -> Html Msg
counterInput model =
    div []
        [ input
            [ type' "number"
            , onInput OnInput
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
