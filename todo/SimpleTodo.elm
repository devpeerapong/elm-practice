module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App


type alias Todo =
    String


type alias Model =
    { todoList : List Todo
    , input : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model [] "", Cmd.none )


type Msg
    = AddTodo
    | OnInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput val ->
            ( { model
                | input = val
              }
            , Cmd.none
            )

        AddTodo ->
            ( { model
                | todoList = model.input :: model.todoList
                , input = ""
              }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ todoInput model
        , todoList model
        ]


todoInput : Model -> Html Msg
todoInput model =
    div []
        [ input
            [ type' "text"
            , placeholder "Add todo"
            , value model.input
            , onInput OnInput
            ]
            []
        , button
            [ type' "button"
            , onClick AddTodo
            ]
            [ text "Add" ]
        ]


todoList : Model -> Html Msg
todoList model =
    model.todoList
        |> List.map (\todo -> todoItem todo)
        |> div []


todoItem : Todo -> Html Msg
todoItem todo =
    h3 []
        [ text todo ]


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
