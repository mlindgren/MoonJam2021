extends Node

const MAX_HOLE = 17 # needs to be n + 1
enum GAME_MODE {GOD_GAMER, HARDSTUCK_PLAT}
var currHole = 1
var ballInHole = false
var hitPoints = 3
var score = 0

var game_mode = GAME_MODE.HARDSTUCK_PLAT
