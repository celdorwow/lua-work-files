### Usage:

`Parser:new(STRING)`

Returns a new object. STRING contains space-separated groups. Each group has the following form `PRAMATER_NAME ARG1 [... ARGN]`
<br />

`P_OBJ:ParseInput(PARAMETER, N_ARGUMENTS)`

Returns a table with at least one element if a parameter is valid. Otherwise, an empty table is returned. Each element is an array with `PARAMETER` name and a number indicating # of arguments after the parameter. If N_ARGUMENTS is omitted or equal to 0, this array only contains a parameter name.
**Note**: multiple occurrences of the same parameter name are valid.
<br />

`P_OBJ:ParseAllInputs(LOOKUPTABLE)`

Searching for parameters in bulk. LOOKUPTABLE is an array of elements, each of which is an array of two values: `{PARAMETER_NAME, N_ARGUMENTS}`.
**Note**: ParseAllInputs will search for multiple occurrences of the same parameter name.
