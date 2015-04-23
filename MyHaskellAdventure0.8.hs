import Control.Concurrent                             -- Wird für Superprint benötigt
import Control.Monad
import Data.List                                           -- Wird für delete benötigt
import System.Random
import System.IO
import System.Console.ANSI

-- Syntax
--    Do you want to (1) .. or (2) ..
--    Take your choice: (1) .. (2) ..

-- Programmaufbau
-- #1 Startelement mit einführenden, einmaligen Worten.
-- #2 Funktion des Bagadders, fügt Items zum Rucksack hinzu.
-- #3 Gruppe der Grundfunktion des Spiels die auf andere Funktionen verweist und auf die während des Spielverlaufes immer wieder zurückverwiesen wird.
-- #4 Funktion des Decision, ersetzt alle früheren If-Abfragen.
-- #5 Minispiel in dem man eine Zahl erraten muss.
-- #6 Funktion des Superprints, regelt die zeitverzögerte Ausgabe.

-- Idee zur Implementierung der Variable meat: meat = xs außer wenn meat verändert wird

data Item = Knife | Wood | Meat | RMeat | Map | Treasure deriving Eq

--superprint " _________________ "
--superprint "|   _,  MAP  /\\__ |"
--superprint "|  |O |     | O  ||"
--superprint "| ,|__|     |____||"
--superprint "|,   o  _  o   o  |"
--superprint "|,   | |O|o|i  |  |"
--superprint "|    _____|____   |"
--superprint "|   |   X      |  |"
--superprint "|   |__________|  |"
--superprint "|_________________|"


-- #1
start =
   do      -- Started das Spiel mit einleitenden Worten.
      superprint "Welcome to my Haskell Adventure game! (ENTER)"
      getLine
      superprint ".."
      superprint "You find yourself on a bright clearance in a jungle."
      function [] "clearance"

-- #2
openbag :: [Item] -> String -> IO()
-- Idee: Erstellen einer If-Bedingung damit die Patchenmatches nicht Überhand nehmen.
-- Zeilen werden ausgegeben wenn Items da sind, am Ende wird an openedbag-itemaction übergeben.

openbag items room = 
   do 
      when (elem Knife items) $ superprint "You got a (1)Knife." 
      when (elem Wood items) $ superprint "You got some (2)Pieces of wood."
      when (elem Meat items) $ superprint "You got some (3)Meat."
      when (elem RMeat items) $ superprint "You got some (4)Roasted meat."
      when (elem Map items) $ superprint "You got a (5)Map."
      if null items
         then do
            superprint "Your bag is empty. Try to collect some items!"
            function [] room
         else do
            superprint "You can (6)Do nothing."
            superprint "What item do you want to use?"
            choice <- getLine
            decision items "openedbag" (read choice) room

-- #3
function :: [Item] -> String -> IO()
function items "clearance" = 
   do
      getLine
      clearScreen
      putStrLn "                                        _________________ "
      putStrLn "                                       |   __  MAP  ____ |"
      putStrLn "                                       |  |O |     | O  ||"
      putStrLn "                                       |  |__|     |____||"
      putStrLn "                                       |       _         |"
      putStrLn "                                       |      |O|        |"
      putStrLn "                                       |    __________   |"
      putStrLn "                                       |   |   X      |  |"
      putStrLn "                                       |   |__________|  |"
      putStrLn "                                       |_________________|"
      superprint "Take your choice: (1)Leave the clearance, (2)Search through the clearance, (3)Wait, (4)Open my bag"
      choice <- getLine
      decision items "clearance" (read choice) "decision decides where to go."

function items "itemdecision_clearance" = 
   do
      superprint "Options: "
      when (not (elem Knife items)) $ superprint "(1)Take the knife"
      when (not (elem Wood items)) $ superprint "(2)Take the wood"
      when (not (elem Knife items) && not (elem Wood items)) $ superprint "(3)Take both of them"
      if (elem Knife items && elem Knife items) 
         then do
            superprint "None, because this is an empty place, no reason to leave rubbish here!"
            function items "clearance"
         else do
            superprint "(4)Do nothing."
            choice <- getLine
            decision items "itemdecision_clearance" (read choice) "clearance"

function items "jungle" =
   do
      getLine
      clearScreen
      putStrLn "                                        _________________ "
      putStrLn "                                       |   __  MAP  ____ |"
      putStrLn "                                       |  |O |     | O  ||"
      putStrLn "                                       |  |__|     |____||"
      putStrLn "                                       |       _         |"
      putStrLn "                                       |      |X|        |"
      putStrLn "                                       |    __________   |"
      putStrLn "                                       |   |   O      |  |"
      putStrLn "                                       |   |__________|  |"
      putStrLn "                                       |_________________|"
      superprint "Now you find yourself deep inside a jungle with tall & big trees, many insects and alot of green everywhere."
      superprint "Take your choice: (1)Travel further, (2)Search through the jungle, (3)Wait, (4)Open my bag"
      choice <- getLine
      if ((read choice) == 1) 
         then do
            superprint "You're lost, it's not sure where you will go now."
            x <- (randomRIO (0::Int, 3))
            if (x == 1) 
               then do
                  superprint "Suddenly you find yourself infront of a village."
                  superprint "You enter the village..."
                  getLine
                  function items "village"
               else if (x == 2)
                  then do
                     superprint "Suddenly you arrive at the clearance again."
                     function items "clearance"
                  else if (x == 3)
                     then do
                        superprint "You have to abruptly stop running, because..."
                        getLine
                        function items "cliff"
                     else function items "jungle"
         else
            decision items "jungle" (read choice) "decision decides where to go."

function items "village" = 
   do
      getLine
      clearScreen
      putStrLn "                                        _________________ "
      putStrLn "                                       |   __  MAP  ____ |"
      putStrLn "                                       |  |O |     | X  ||"
      putStrLn "                                       |  |__|     |____||"
      putStrLn "                                       |       _         |"
      putStrLn "                                       |      |O|        |"
      putStrLn "                                       |    __________   |"
      putStrLn "                                       |   |   O      |  |"
      putStrLn "                                       |   |__________|  |"
      putStrLn "                                       |_________________|"
      superprint "You are surrounded by barely-clothed indian warriors."
      superprint "Take your choice: (1)Leave the village, (2)Search through the village, (3)Talk to warrior #1, (4)Talk to warrior #2"
      choice <- getLine
      decision items "village" (read choice) "decision decides where to go."

function items "cliff" = 
   do
      getLine
      clearScreen
      putStrLn "                                        _________________ "
      putStrLn "                                       |   __  MAP  ____ |"
      putStrLn "                                       |  |X |     | O  ||"
      putStrLn "                                       |  |__|     |____||"
      putStrLn "                                       |       _         |"
      putStrLn "                                       |      |O|        |"
      putStrLn "                                       |    __________   |"
      putStrLn "                                       |   |   O      |  |"
      putStrLn "                                       |   |__________|  |"
      putStrLn "                                       |_________________|"
      superprint "You find yourself on the top of a cliff, where it goes down very steeply. You take a break and think about what to do."
      superprint "Take your choice: (1)Leave the cliff, (2)Search through the cliff, (3)Wait, (4)Open my bag"
      choice <- getLine
      decision items "cliff" (read choice) "decision decides where to go."

function items "bear" = 
   do
      superprint "             (()__(()"
      superprint "            /        \\ "
      superprint "           ( /      \\ \\"
      superprint "            \\  o o    /"
      superprint "            (_()_)__/ \\ "  
      superprint "            /_,==.____ \\                                    A wild bear appears!"
      superprint "           (  |- -|     )                               He has not noticed you yet,"
      superprint "          /\\_.|___|'-.__/\\_                        as he is eating honey out of a can!"
      superprint "         /(        /       \\     "
      superprint "         \\  \\      (       /      Do you want to (1)Fight him with the knife or (2)Run away before he notices you"
      superprint "         ) '.______)      /                                But you can also (3)Wait."
      superprint "     (((____.---(((______/"
      choice <- getLine
      decision items "bear" (read choice) "jungle"

function _ "bear2" = 
   do
      putStrLn "          ( )___( )"
      putStrLn "          /__oo   \\"
      putStrLn "         ( \\       )"
      putStrLn "         | `=/     |"
      putStrLn "        /           \\"
      putStrLn "       /  /     \\    \\"
      putStrLn "      /  (       \\    \\ "
      putStrLn "     ( ,_/        \\    \\                    OK, NOW YOU ARE IN DANGER! (ENTER)"
      putStrLn "      \\_ '=        \\    \\"
      putStrLn "       \"|'          /   /"
      putStrLn "        ;          /   /'"
      putStrLn "        :         (((( /"
      putStrLn "         `._      \\  _ ("
      putStrLn "          __|    |  /_    "
      putStrLn "         (\"__,..\"'_._.)   "
      decision <- getLine
      superprint "..."
      getLine
      superprint "..."
      getLine
      putStrLn("The wild bear has totally eaten you now, you are dead. Game Over.")

-- #4
-- Eingabe: decision <Variablen> <aktueller Raum> <Entscheidung> <Folgezustand>
decision :: [Item] -> [Char] -> Integer -> [Char] -> IO ()

-- Top level: Clearance
decision items "clearance" choice _
      | choice == 1 = function items "jungle"
      | choice == 2 = function items "itemdecision_clearance"
      | choice == 3 = do
            superprint "Nothing happens.."
            function items "clearance"
      | choice == 4 = openbag items "clearance"

-- Second level: Clearance
decision items "itemdecision_clearance" choice next
      | choice == 1 && not (elem Knife items) = do
            superprint "New item: knife."
            function (Knife:items) next
      | choice == 2 && not (elem Wood items) = do
            superprint "New item: peaces of wood."
            function (Wood:items) next
      | choice == 3 && not (elem Wood items) && not (elem Knife items) = do
            superprint "New items: knife and peaces of wood."
            function (Knife:Wood:items) next
      | choice == 4 = function items next

-- Top level: Jungle
decision items "jungle" choice _
      | choice == 2 = do
            superprint "This is an empty place, no reason to leave rubbish here!"
            function items "jungle"
      | choice == 3 = do
            superprint "Jesus, Holy Christ, Mama mia, What the freaking hell, Oh my god.. (ENTER)"
            getLine
            function items "bear"
      | choice == 4 = openbag items "jungle"

-- Top level: Village
decision items "village" 1 _ = function items "jungle"

decision items "village" 2 _ = 
   do
      superprint "The villagers caught you searching through their property, got angry, stole your bag and kicked you out of their village."
      superprint "You have lost all of your items."
      function [] "jungle"

decision items "village" 3 _ = 
   do
      superprint "        www"
      superprint "       /n n\\        /\\"
      superprint "       |/^\\|       /  \\"
      superprint "       | , |       ^||^"
      superprint "        \\_/         ||"
      superprint "        _U_         ||"
      superprint "      /`   `''-----'P3"
      superprint "     / |. .|''-----'||"
      superprint "     \\'|   |        ||"
      superprint "      \\|   |        ||        Hello, im warrior #1 and i will only talk to you for some roasted meat!"
      superprint "       E   |        ||"
      superprint "      /#####\\       ||"
      superprint "      /#####\\       ||"
      superprint "        |||         ||"
      superprint "        |||         ||"
      superprint "        |||         ||"
      superprint "        |||         ||                                  What do you want to do?"   
      superprint "       molom        Ll                                  (1)Trade (2)Do nothing."
      choice <- getLine
      decision items "warrior1" (read choice) "village"

decision items "village" 4 _ =
   do 
      superprint "         \\\\\\|||/// "
      superprint "       .  =======    "
      superprint "      / \\| O   O |   "
      superprint "      \\ /  \\v_'/                 Uga-Uga, warrior #2 i am and if a real man you are, fight me!"
      superprint "       #   _| |_     "
      superprint "      (#) (     )    "
      superprint "       #\\//|* *|\\\\   "
      superprint "       #\\/(  *  )/   "
      superprint "       #   =====     "
      superprint "       #   (\\ /)     "
      superprint "       #   || ||     "
      superprint "      .#---'| |----." 
      superprint "       #----' -----'"
      getLine
      superprint "The fight begins..."
      getLine
      superprint "You lost."
      superprint "You di - wait! One last chance i give you! I spare you if this small game you win i invented."
      superprint "Its called 'Mambaha'. A number between 1 and 10 i guess and if you guess it you won, if not, you lose!"
      minigame items
      function items "village"

-- Second level: Village
decision items "warrior1" choice next
      | choice == 1 && elem RMeat items = do
            superprint "I get the roasted meat and you get the map of the position of the treasure."
            superprint "New item: map."
            function (delete RMeat (Map : items)) next
      | choice == 1 && not (elem RMeat items) = do
            superprint "You don't even have roasted meat! Come back later."
            function items next
      | choice == 2 = function items next

-- Top level: Cliff
decision items "cliff" choice _
      | choice == 1 = function items "jungle"
      | choice == 2 && not (elem Map items) = do
            superprint "This is an empty place, no reason to leave rubbish here!"
            function items "cliff"
      | choice == 2 && elem Map items = do
            superprint "This is an empty place, no reason - but wait!"
            getLine
            superprint "..."
            getLine
            superprint "..."
            getLine
            superprint "                   ,gaaaaaaaagaaaaaaaaaaaaagaaaaaaaag,"
            superprint "                 ,aP8b    _,dYba,       ,adPb,_    d8Ya,"
            superprint "               ,aP\"  Yb_,dP\"   \"Yba, ,adP\"   \"Yb,_dP  \"Ya,"
            superprint "             ,aP\"    _88\"         )888(         \"88_    \"Ya,"
            superprint "           ,aP\"   _,dP\"Yb      ,adP\"8\"Yba,      dP\"Yb,_   \"Ya,"
            superprint "         ,aPYb _,dP8    Yb  ,adP\"   8   \"Yba,  dP    8Yb,_ dPYa,"
            superprint "       ,aP\"  YdP\" dP     YbdP\"      8      \"YbdP     Yb \"YbP  \"Ya,"
            superprint "      I8aaaaaa8aaa8baaaaaa88aaaaaaaa8aaaaaaaa88aaaaaad8aaa8aaaaaa8I"
            superprint "      `Yb,   d8a, Ya      d8b,      8      ,d8b      aP ,a8b   ,dP'"
            superprint "        \"Yb,dP \"Ya \"8,   dI \"Yb,    8    ,dP\" Ib   ,8\" aP\" Yb,dP\""
            superprint "          \"Y8,   \"YaI8, ,8'   \"Yb,  8  ,dP\"   `8, ,8IaP\"   ,8P\""
            superprint "            \"Yb,   `\"Y8ad'      \"Yb,8,dP\"      `ba8P\"'   ,dP\""
            superprint "              \"Yb,    `\"8,        \"Y8P\"        ,8\"'    ,dP\""
            superprint "                \"Yb,    `8,         8         ,8'    ,dP\""
            superprint "                  \"Yb,   `Ya        8        aP'   ,dP\""
            superprint "                    \"Yb,   \"8,      8      ,8\"   ,dP\""
            superprint "                      \"Yb,  `8,     8     ,8'  ,dP\""
            superprint "                        \"Yb, `Ya    8    aP' ,dP\""
            superprint "                          \"Yb, \"8,  8  ,8\" ,dP\""
            superprint "                            \"Yb,`8, 8 ,8',dP\""
            superprint "                              \"Yb,Ya8aP,dP\""
            superprint "                                \"Y88888P\""
            superprint "                                  \"Y8P\""
            superprint "                                    \""
            superprint "New Item: treasure."
            -- (Treasure : items)
            superprint "Holy Bimbam, you found the treasure! Press ENTER to approve that you feel awesome and encouraged to start something legendary right now!"
            getLine
            superprint "Great! One more time!"
            getLine
            superprint "Finally your long and pleasant journey ends, good job."
      | choice == 3 = do
            getLine
            superprint "..."
            getLine
            superprint "..."
            getLine
            superprint "You fell off the cliff and lost your bag."
            superprint "You have lost all of your items."
            superprint "In addition, you died. Game over."
      | choice == 4 = openbag items "cliff"

-- Top level: Bear
decision items "bear" choice next
      | choice == 1 && elem Knife items = do
            decision <- getLine
            superprint "..."
            getLine
            superprint "..."
            getLine 
            superprint "Wow, you have totally beaten up the wild bear!"
            superprint "(Good news) New Item: meat."
            superprint "(Bad news) During the battle you had to smash the knife right in the bears face, so it broke."
            getLine
            function (delete Knife (Meat:items)) next
      | choice == 1 && not (elem Knife items) = do
            superprint "Oh my god you don't even got a knife with you, you cant kill that strong bear"
            superprint "with your hands, Game Over."
      | choice == 2 = do
            superprint "You ran far and fast and the bear has gone.."
            function items next
      | choice == 3 = function items "bear2"

-- Second level: openedbag
-- In diesem Teil wird durch die guards auch noch einmal überprüft ob das item tatsächlich da ist, um zu verhindern, dass eine nicht
-- angezeigte Option ausgewählt wird und das Spiel dann davon ausgeht dass das Item existiert.
decision items "openedbag" choice room
      | choice == 1 && elem Knife items = do
            superprint "You cant do things with your knife at the moment."
            function items room
      | choice == 2 && elem Wood items = do
            superprint "Do you want to (1)Make a fire or (2)Do nothing"
            choice <- getLine
            decision items "openedbag-itemaction" (read choice) room
      | choice == 3 && elem Meat items = do
            superprint "You cant do things with your meat at the moment."
            function items room
      | choice == 4 && elem RMeat items = do
            superprint "You cant do things with your roasted meat at the moment."
            function items room
      | choice == 5 && elem Map items = do
            superprint "Do you want to (1)Open it or (2)Destroy it to never find the treasure and to wander around in this odd world until you die."
            choice <- getLine
            decision items "map" (read choice) "decision decides where to go."
      | choice == 6 = function items room

-- openedbag-itemaction in Abhängigkeit von den Eingabeparametern
decision items "openedbag-itemaction" choice room
      | choice == 1 && not (elem Meat items) = do
            superprint "You have successfully used your peaces of wood to make a fire."
            superprint "           ("
            superprint "            )"        
            superprint "           (  ("    
            superprint "               )                     You need a specific item to do something with the fire!"     
            superprint "         (    ("
            superprint "          ) /\\  )                            You have to (2)Do nothing with the fire"
            superprint "        (  // |  (`"  
            superprint "      _ -.;_/ \\\\--._ "
            superprint "     (_;-// | \\ \\-'.\\"
            superprint "      `'(_ )_)(_)_)'"
            choice <- getLine
            decision (delete Wood items) "fire" (read choice) room
      | choice == 1 && elem Meat items = do
            superprint "You have successfully used your peaces of wood to make a fire."
            superprint "           ("
            superprint "            )"        
            superprint "           (  ("    
            superprint "               )"     
            superprint "         (    ("
            superprint "          ) /\\  )              Do you want to (1)Grill the meat or (2)Do nothing with the fire"
            superprint "        (  // |  (`"  
            superprint "      _ -.;_/ \\\\--._ "
            superprint "     (_;-// | \\ \\-'.\\"
            superprint "      `'(_ )_)(_)_)'"
            choice <- getLine
            decision (delete Wood (Meat:items)) "fire" (read choice) room
      | choice == 2 = function items room

-- fire in Abhängigkeit von den Eingabeparametern
decision items "fire" choice room
      | choice == 1 = do
            superprint "You have successfully grilled the meat. It smells good."
            superprint "New item: grilled meat."
            getLine
            superprint "There is no fire anymore."
            function (delete Wood (delete Meat (RMeat:items))) room
      | choice == 2 = function items room

-- map in Abhängigkeit von den Eingabeparametern
decision items "map" choice _
      | choice == 1 = do
            superprint "You finally look at the map and you see a trace from the village right to a cliff,"
            superprint "where obviously the treasure is hidden."
            getLine
            superprint "Now You find yourself on a bright clearance in a jungle."
            function items "clearance"
      | choice == 2 = do
            superprint "Because you will wander in this world for so long, things dont matter anymore,"
            superprint "and there is no sense in displaying your actual room."
            getLine
            superprint "..."
            getLine
            superprint "Oh my god, i have to stop 'calculating' about this. Game over!"

-- Das finale Pattern in Unabhängigkeit von den Eingabeparametern
-- Achtung: muss am Ende stehen!
decision items _ _ _ = 
   do
      superprint "I'm sorry, i can't understand your input. I teleport you to the clearance."
      function items "clearance"

-- #5
minigame items = 
   do
      superprint "Guess my number!"
      input <- getLine
      x <- (randomRIO (1::Int, 10))
      if ((read input) == x)
         then
            superprint "Wow, you knew my number!"
         else do
            superprint "You lost!"
            getLine
            superprint "..."
            getLine
            superprint "Okey, one last chance! New number, new game!"
            minigame items

-- #6
superprint :: String -> IO ()                     -- Superprint regelt die zeitversetzte Ausgabe
superprint [] = do putStrLn "" 
                   return ()
superprint (x:xs) = do putChar (x)                -- gibt den vordersten Buchstaben aus
                       sleep 1                    -- wartet
                       superprint (xs)            -- macht das selbe nochmal mit dem rest

sleep :: Int -> IO ()
sleep n = threadDelay (n * second) where second = 10000

-- Sleep function copied from
-- http://hackage.haskell.org/packages/archive/happstack-util/
-- 0.3.1/doc/html/src/Happstack-Util-Concurrent.html
