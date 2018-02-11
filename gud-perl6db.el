(defun perl6db (command-line)
  "Run perl6db on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger."
  (interactive
   (list (gud-query-cmdline 'perl6-debug-m
			    (concat (or (buffer-file-name) "-e 0") " "))))

  (gud-common-init command-line 'gud-perl6db-massage-args
		   'gud-perl6db-marker-filter)
  (set (make-local-variable 'gud-minor-mode) 'perl6db)

  (gud-def gud-break  "bp add %f %l" "\C-b" "Set breakpoint at current line.")
  (gud-def gud-remove "bp rm %f %l"  "\C-d" "Remove breakpoint at current line")
  (gud-def gud-step   ""             "\C-s" "Step one source line with display.")
  (gud-def gud-next   "s"            "\C-n" "Step one line (skip functions).")
  (gud-def gud-cont   "r"            "\C-r" "Run until the next breakpoint or an exception is thrown.")
  (gud-def gud-print  "p %e"          "\C-p" "Evaluate perl expression at point.")


  (setq comint-prompt-regexp "^\\([>]\\|- .*[?]\\) ")
  (setq paragraph-start comint-prompt-regexp)
  (run-hooks 'perl6db-mode-hook))

(defun gud-perl6db-massage-args (_file args)
  "Convert a command line as would be typed normally to run perldb
into one that invokes an Emacs-enabled debugging session."
  args)

(defun gud-perl6db-marker-filter (string)
  "Filter the output of perl6-debug-m to watch for source file positions.
Returns what should be shown in the GUD buffer, as a string"
  string)
