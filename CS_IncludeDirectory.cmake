include_guard(GLOBAL)

# include a CMake file in a directory relative to CMAKE_CURRENT_SOURCE_DIR with a name following the dir/_dir.cmake pattern
macro(cs_include_directory DIR)
    set(__CS_DETAIL_DIR "${DIR}")
    cmake_path(GET __CS_DETAIL_DIR FILENAME __CS_DETAIL_DIR_FILENAME)
    include("${CMAKE_CURRENT_SOURCE_DIR}/${__CS_DETAIL_DIR}/_${__CS_DETAIL_DIR_FILENAME}.cmake")
endmacro()
