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

       environment division.
         input-output section.
           file-control.
           select brainfuck-code assign to dynamic filename
           organization is sequential.

       data division.
         file section.
           fd brainfuck-code.
           01 brainfuck-code-file.
              05 command-char PIC X(999).
         working-storage section.
           01 command PIC X.

           01 prog-table.
             05 prog-tape PIC X VALUE "c" OCCURS  999 TIMES.

           01 storrage-table.
             05 main-tape PIC S999 VALUE 0 OCCURS 999 TIMES.

           01 tape-pointer PIC 999.

           01 prog-pointer PIC 999.

           01 input-char PIC X.

           01 bracket-skip PIC 1.
           01 bracket-depth PIC 99.

           01 execute-direction PIC S9.

           01 filename PIC X(30).

       procedure division.

      *> default values

         move +1 to execute-direction.
         move "s" to command.
      
      *> get filename
       accept filename from command-line.

      *> read input program
         open input brainfuck-code.
           read brainfuck-code into prog-table
           end-read
         close brainfuck-code.

      *> run the inputed programm

         perform repl-loop until (command = " " or prog-pointer > 998).
        
         goback.


         repl-loop.
           move prog-tape(prog-pointer + 1) to command.

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

           add execute-direction to prog-pointer giving prog-pointer
         .

         deal-with-open-bracket.
           if execute-direction = +1 then
               if bracket-skip = 1 then
                   add 1 to bracket-depth giving bracket-depth
               else
                   if main-tape((tape-pointer + 1)) = 0 then
                       move 1 to bracket-skip
                       move +1 to execute-direction
                   end-if
               end-if
           else
               if bracket-depth = 0 then
                   move 0 to bracket-skip
                   move 1 to execute-direction
               end-if
               if bracket-skip = 1 then
                   add -1 to bracket-depth giving bracket-depth
               end-if
           end-if
         .

         deal-with-closing-bracket.
           if execute-direction = +1 then
               if not main-tape((tape-pointer + 1)) = 0 then
                   move 1 to bracket-skip
                   move -1 to execute-direction
               else 
                   if bracket-depth = 1 then
                       add -1 to bracket-depth giving bracket-depth
                   else
                       move 0 to bracket-skip
                       move 1 to execute-direction
                   end-if
               end-if
           else
               if bracket-skip = 1 then
                   add 1 to bracket-depth giving bracket-depth
               end-if
           end-if
         .

         move-forwad-command.
      *>   Also implement wraping for tape
           if tape-pointer = 998 then
               move 0 to tape-pointer
           else
               add 1 to tape-pointer giving tape-pointer
           end-if
         .

         move-backward-command.
           if tape-pointer = 0 then
               move 998 to tape-pointer
           else
               add -1 to tape-pointer giving tape-pointer
           end-if
         .

         output-command.
           display FUNCTION CHAR(main-tape(tape-pointer + 1) + 1)
           with no advancing
         .

         input-command.
           accept input-char from sysin.
           move FUNCTION ORD(input-char) 
      -         to main-tape((tape-pointer + 1))
      *>   Since this great programming language starts at 1 every number has to be shifted by 1
           add -1 to main-tape((tape-pointer + 1))
      -        giving main-tape((tape-pointer + 1))
         .

         remove-one-command.
      *>   Brainfuck only allows for values between 0 and 255
           if main-tape((tape-pointer + 1)) = 0 then
               move 255 to main-tape((tape-pointer + 1))
           else
               add -1 to main-tape((tape-pointer + 1)) 
      -               giving main-tape((tape-pointer + 1))
           end-if
         .

         add-one-command.
      *>   Brainfuck only allows for values between 0 and 255
           if main-tape((tape-pointer + 1)) = 255 then
               move 0 to main-tape((tape-pointer + 1))
           else
               add 1 to main-tape((tape-pointer + 1)) 
      -               giving main-tape((tape-pointer + 1))
           end-if
         .

       end program brainfuck.
       

      *> TODO: implement closing bracket!
