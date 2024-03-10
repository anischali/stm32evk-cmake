include(project.cmake)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_LINKER arm-none-eabi-ld)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)

set(CMAKE_SYSTEM_NAME Generic) # Or name of your OS if you have one
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

add_compile_options(
    -std=gnu11 -mcpu=${STM32_PROJECT_CPU} -nostdlib -specs=nano.specs
    -ffunction-sections -fdata-sections -ffreestanding -flto -fno-strict-aliasing
    -mthumb -mtune=${STM32_PROJECT_CPU} -g -ggdb -Og -g3 -Wall -fmessage-length=0 
    ${STM32_MFLOAT_ABI} -Wall -MD
)

set (CMAKE_ASM_FLAGS "${CMAKE_CXX_FLAGS} -x assembler-with-cpp")

add_link_options(
    -mthumb -specs=nosys.specs -Wl,-Map=${STM32_PROJECT_NAME}.map 
    -std=gnu11 -Wl,--start-group -lm  -Wl,--end-group -Wl,--gc-sections -g3 -Os -ggdb 
    -mcpu=${STM32_PROJECT_CPU} -Wl,--entry=Reset_Handler -Wl,--cref -Wl,--print-memory-usage 
    -T${CMAKE_CURRENT_BINARY_DIR}/../${STM32_PROJECT_LDSCRIPT} 
)

add_link_options(${STM32_LIB_EXTRA_LIBS})
add_definitions(
    ${STM32_EXTRA_DEFINITIONS}
    -D${STM32_PROJECT_DEVICE_FAMILY}=1
    -D${STM32_PROJECT_DEVICE}=1
)
include_directories(${STM32_PROJECT_HEADERS_DIR})