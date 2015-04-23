data Program =
   PDefs [Def]
  deriving (Eq,Ord,Show,Read)
data Stm =
   SExp Exp
 | SDecls Type [Id]
 | SInit Type Id Exp
 | SReturn Exp
 | SWhile Exp Stm
  deriving (Eq,Ord,Show,Read)
