extends Node

<<<<<<< HEAD
const MAX_HOLE = 16 # needs to be n + 1
=======
enum GAME_MODE {GOD_GAMER, HARDSTUCK_PLAT}

const MAX_HOLE = 15 # needs to be n + 1

>>>>>>> ec45ba7c0917261d3b42f1f3b74d5d6083175ec3
var currHole = 1
var ballInHole = false
var hitPoints = 3
var score = 0

var game_mode = GAME_MODE.HARDSTUCK_PLAT
