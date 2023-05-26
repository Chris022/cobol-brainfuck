      *> This is a brainfuck repl written in COBOL. Why? Because I can.
      *> Combilation:
      *>   cobc -x main.cbl
      *>
      *> Running:
      *>   ./main
      *> 
      *> Usage:
      *>   For information about Brainfuck, check this link: https://esolangs.org/wiki/Brainfuck

       identification division.
         program-id. brainfuck.
       data division.
         working-storage section.
           01 command PIC X.

           01 prog-table.
             05 prog-tape PIC X VALUE "c" OCCURS  200 TIMES.

           01 storrage-table.
             05 main-tape PIC S999 VALUE 0 OCCURS 200 TIMES.

           01 tape-pointer PIC 999.

           01 prog-pointer PIC 999.

           01 input-char PIC X.

           01 bracket-skip PIC 1.
           01 bracket-depth PIC 99.
       procedure division.

         accept prog-table from sysin.

      *> run the inputed programm

         perform repl-loop until (command = "c" or prog-pointer > 998).
        
         goback.


         repl-loop.
           move prog-tape(prog-pointer + 1) to command.
           add 1 to prog-pointer giving prog-pointer.

           if command = "c" then
               display "REPL ending. Press any key...".
           if command = "[" then
               perform deal-with-open-bracket
           end-if
           if command = "]" then
               perform deal-with-closing-bracket
           end-if
           if bracket-skip = 0 then
               if command = "+" then
                   perform add-one-command
               end-if
               if command = "-" then
                   perform remove-one-command
               end-if
               if command = "." then
                   perform output-command
               end-if
               if command = "," then
                   perform input-command
               end-if
               if command = "<" then
                   perform move-backward-command
               end-if
               if command = ">" then
                   perform move-forwad-command
               end-if
           end-if
         .

         deal-with-open-bracket.
           if bracket-skip = 1 then
               add 1 to bracket-depth giving bracket-depth
           else
               if main-tape((tape-pointer + 1)) = 0 then
                   move 1 to bracket-skip
           end-if
         .

         deal-with-closing-bracket.
           if bracket-depth = 0 then
               move 0 to bracket-skip
           else
               add -1 to bracket-depth giving bracket-depth
           end-if
         .

         move-forwad-command.
           add 1 to tape-pointer giving tape-pointer
         .

         move-backward-command.
           add -1 to tape-pointer giving tape-pointer
         .

         output-command.
      *>     display FUNCTION CHAR(main-tape(internal-tape-pointer))
      *>     with no advancing
           display main-tape((tape-pointer + 1))
         .

         input-command.
           accept input-char from sysin.
           move FUNCTION ORD(input-char)
      -        to main-tape((tape-pointer + 1))
         .

         remove-one-command.
  
           add -1 to main-tape((tape-pointer + 1)) 
      -               giving main-tape((tape-pointer + 1))
         .

         add-one-command.
           add 1 to main-tape((tape-pointer + 1)) 
      -               giving main-tape((tape-pointer + 1))
         .

       end program brainfuck.
       

      *> TODO: implement closing bracket!