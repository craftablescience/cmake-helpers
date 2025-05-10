include_guard(GLOBAL)

# create a variable named PROJECT_VERSION_PRETTY in the current scope based on the tweak number:
# 1.0.0     => 1.0.0
# 1.0.0.1   => 1.0.0-beta.1
# 1.0.0.99  => 1.0.0-rc.1
# 1.0.0.999 => 1.0.0-rc.2
macro(cs_version_pretty)
    if(PROJECT_VERSION_TWEAK STREQUAL "")
        # Proper release version
        set(PROJECT_VERSION_PRETTY "${PROJECT_VERSION}" CACHE STRING "" FORCE)
    elseif(PROJECT_VERSION_TWEAK MATCHES "^99+$")
        # Release candidate, number of 9s controls the RC number
        string(LENGTH ${PROJECT_VERSION_TWEAK} PROJECT_VERSION_TWEAK_LENGTH)
        math(EXPR PROJECT_VERSION_TWEAK_LENGTH "${PROJECT_VERSION_TWEAK_LENGTH} - 1" OUTPUT_FORMAT DECIMAL)
        set(PROJECT_VERSION_PRETTY "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}-rc.${PROJECT_VERSION_TWEAK_LENGTH}" CACHE STRING "" FORCE)
    else()
        # Beta version
        set(PROJECT_VERSION_PRETTY "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}-beta.${PROJECT_VERSION_TWEAK}" CACHE STRING "" FORCE)
    endif()
endmacro()
