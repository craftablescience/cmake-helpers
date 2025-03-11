include_guard(GLOBAL)

# run this directly after project() in the top level CMakeLists.txt
macro(cs_configure_defaults LTO_OPTION)
    set(CMAKE_SKIP_BUILD_RPATH OFF)
    set(CMAKE_BUILD_RPATH_USE_ORIGIN ON)
    set(CMAKE_INSTALL_RPATH $ORIGIN)

    set(CMAKE_POSITION_INDEPENDENT_CODE ON)

    include(CheckIPOSupported)
    if(${LTO_OPTION})
        check_ipo_supported(RESULT ${LTO_OPTION})
    endif()
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ${${LTO_OPTION}})
endmacro()
