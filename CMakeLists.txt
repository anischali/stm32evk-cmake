cmake_minimum_required(VERSION 3.5.0)

include(${CMAKE_CURRENT_SOURCE_DIR}/stm-toolchain.cmake)

include(${CMAKE_CURRENT_SOURCE_DIR}/project.cmake)


project(${STM32_PROJECT_NAME} VERSION ${STM32_PROJECT_VERSION})

enable_language(ASM C CXX)

add_executable(${STM32_PROJECT_NAME}.elf
    ${STM32_PROJECT_SOURCES}
    ${STM32_LIB_EXTRA_SOURCES}
)

include_directories(${STM32_PROJECT_HEADERS_DIR} ${STM32_LIB_EXTRA_HEADERS})

add_custom_command(
		TARGET ${STM32_PROJECT_NAME}.elf POST_BUILD
		COMMAND ${CMAKE_OBJCOPY} -O ihex ${STM32_PROJECT_NAME}.elf ${STM32_PROJECT_NAME}.hex
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Generate .hex extension file firmware")

add_custom_command(
        TARGET ${STM32_PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary ${STM32_PROJECT_NAME}.elf ${STM32_PROJECT_NAME}.bin
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generate .bin extension file firmware")

add_custom_command(
        TARGET ${STM32_PROJECT_NAME}.elf 
        COMMAND ${CMAKE_OBJCOPY} -O binary ${STM32_PROJECT_NAME}.elf ${STM32_PROJECT_NAME}.bin
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generate .bin extension file firmware")

add_custom_command(
        TARGET ${STM32_PROJECT_NAME}.elf 
        COMMAND echo "binary_elf=${STM32_PROJECT_NAME}.elf" > build.env && echo "jlink_device=${STM32_JLINK_DEVICE}" >> build.env
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generate build.env for debugging")

SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)