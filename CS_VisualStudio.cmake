include_guard(GLOBAL)

# run this directly after project() in the top level CMakeLists.txt
macro(cs_setup_vs_defaults)
    set(CMAKE_FOLDER "Thirdparty" CACHE INTERNAL "" FORCE)
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endmacro()
