include_guard(GLOBAL)

# function to set up many things at once for a given target
function(cs_configure_target TARGET)
    cmake_parse_arguments(PARSE_ARGV 1 "CONFIGURE_TARGET" "LOGO;MANIFEST" "" "")

    # Define DEBUG macro
    target_compile_definitions(${TARGET} PRIVATE "$<$<CONFIG:Debug>:DEBUG>")

    # Set optimization flags
    if(CMAKE_BUILD_TYPE MATCHES "Debug")
        # Build with debug friendly optimizations and debug symbols (MSVC defaults are fine)
        if(UNIX OR MINGW)
            target_compile_options(${TARGET} PRIVATE -Og -g)
        endif()
        if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT MSVC)
            target_compile_options(${TARGET} PRIVATE -fno-limit-debug-info)
        endif()
    else()
        # Build with optimizations and don't omit stack pointer for debugging (MSVC defaults are fine)
        if(UNIX OR MINGW)
            target_compile_options(${TARGET} PRIVATE -O2 -fno-omit-frame-pointer)
        endif()
    endif()

    if(WIN32 AND MSVC)
        get_target_property(TARGET_TYPE ${TARGET} TYPE)
        get_target_property(TARGET_IS_GUI ${TARGET} WIN32_EXECUTABLE)

        # Organize VS solution into folders
        if(TARGET_TYPE STREQUAL "EXECUTABLE")
            set_target_properties(${TARGET} PROPERTIES FOLDER "Executables")
        else()
            set_target_properties(${TARGET} PROPERTIES FOLDER "Libraries")
        endif()

        if((TARGET_TYPE STREQUAL "SHARED_LIBRARY") OR (TARGET_TYPE STREQUAL "EXECUTABLE"))
            # Create PDBs in release
            target_compile_options(${TARGET} PRIVATE "$<$<CONFIG:Release>:/Zi>")
            target_link_options(${TARGET} PRIVATE "$<$<CONFIG:Release>:/DEBUG>" "$<$<CONFIG:Release>:/OPT:REF>" "$<$<CONFIG:Release>:/OPT:ICF>")

            if(TARGET_TYPE STREQUAL "EXECUTABLE")
                # Add an icon to the executable
                if(CONFIGURE_TARGET_LOGO)
                    target_sources(${TARGET} PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/res/logo.rc")
                endif()

                # Add a manifest to the executable
                if(CONFIGURE_TARGET_MANIFEST)
                    target_sources(${TARGET} PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/res/program.manifest")
                endif()
            endif()
        endif()

        # Don't show the console when running the executable
        if(TARGET_IS_GUI)
            target_link_options(${TARGET} PRIVATE "/ENTRY:mainCRTStartup")
        endif()
    endif()
endfunction()
