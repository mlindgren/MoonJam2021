extends Node

enum GAME_MODE {GOD_GAMER, HARDSTUCK_PLAT}

const MAX_HOLE = 10 # needs to be n + 1
var currHole = 1
var ballInHole = false
var hitPoints = 3
var score = 0

var game_mode = GAME_MODE.HARDSTUCK_PLAT
