function(GenerateOpenCLHeader varname outfile files)
    message("Creating ${outfile}...")
    file(WRITE ${outfile} "const char * ${varname} = \n")
    math(EXPR ARG_END   "${ARGC}-1")

    foreach(IDX RANGE 2 ${ARG_END})
        list(GET ARGV ${IDX} filename)
        file(READ ${filename} content)
        string(REGEX REPLACE "\\s*//[^\n]*\n" "" content "${content}")
        string(REGEX REPLACE "\\\\" "\\\\\\\\" content "${content}")
        string(REGEX REPLACE "\"" "\\\\\"" content "${content}")
        string(REGEX REPLACE "([^\n]+)\n" "\"\\1\\\\n\"\n" content "${content}")
        string(REGEX REPLACE "\n+" "\n" content "${content}")
        file(APPEND ${outfile} "${content}")
    endforeach()

    file(APPEND ${outfile} ";\n")
endfunction(GenerateOpenCLHeader)
