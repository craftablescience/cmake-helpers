include_guard(GLOBAL)

# run this directly after project() in the top level CMakeLists.txt
macro(cs_setup_vs_defaults)
    if(WIN32)
        set(CMAKE_FOLDER "Thirdparty" CACHE INTERNAL "" FORCE)
        set_property(GLOBAL PROPERTY USE_FOLDERS ON)

        # set startup project if specified
        cmake_parse_arguments(__CS_DETAIL_VS_DEFAULTS_OPT "" "STARTUP_PROJECT" "" "${ARGN}")
        if(__CS_DETAIL_VS_DEFAULTS_OPT_STARTUP_PROJECT)
            set_property(
                    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
                    PROPERTY VS_STARTUP_PROJECT "${__CS_DETAIL_VS_DEFAULTS_OPT_STARTUP_PROJECT}")
        endif()
    endif()
endmacro()
