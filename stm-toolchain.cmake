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



# add_compile_options(
#     -D${STM32_PROJECT_PTYPE} -mtune=cortex-m0 -g -ggdb -Os -g3 -Wall -fmessage-length=0 
#     -ffunction-sections -fdata-sections -ffreestanding -flto
#     -pipe -Wall -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration 
#     -Wpointer-arith -std=gnu99 -fno-strict-aliasing -ffunction-sections -fdata-sections 
#     -Wchar-subscripts -Wcomment -Wformat=2 -Wimplicit-int -Wmain -Wparentheses -Wsequence-point 
#     -Wreturn-type -Wswitch -Wtrigraphs -Wunused -Wuninitialized -Wunknown-pragmas -Wfloat-equal 
#     -Wundef -Wshadow -Wbad-function-cast -Wwrite-strings -Wsign-compare -Waggregate-return 
#     -Wmissing-declarations -Wformat -Wmissing-format-attribute -Wno-deprecated-declarations 
#     -Wpacked -Wredundant-decls -Wnested-externs -Wlong-long -Wunreachable-code -Wcast-align 
#     --param max-inline-insns-single=500
# )

add_compile_options(
    -std=gnu11 -mcpu=${STM32_PROJECT_CPU} 
    -mtune=${STM32_PROJECT_CPU} -g -ggdb -Os -g3 -Wall -fmessage-length=0 
    -ffunction-sections -fdata-sections -ffreestanding -flto -nostdlib
    ${STM32_MFLOAT_ABI} -specs=nano.specs -mthumb -Wall -MD
)
set (CMAKE_ASM_FLAGS "${CMAKE_CXX_FLAGS} -x assembler-with-cpp")

#add_link_options(
#    -std=gnu11 -mcpu=${STM32_PROJECT_CPU} -Wl,--entry=Reset_Handler -Wl,--cref -mthumb
#    -T${CMAKE_CURRENT_BINARY_DIR}/../${STM32_PROJECT_LDSCRIPT} -Wl,--print-memory-usage
#    -mthumb -flto -ffreestanding -mtune=${STM32_PROJECT_CPU} -nostartfiles -nostdlib
#    -Xlinker --Map=${STM32_PROJECT_NAME}.map -specs=nosys.specs -specs=nano.specs 
#    -static -Wl,--start-group -lc -lm -Wl,--end-group
#)

add_link_options(
    -std=gnu11 -T${CMAKE_CURRENT_BINARY_DIR}/../${STM32_PROJECT_LDSCRIPT} -Xlinker --gc-sections 
    -specs=nosys.specs -Wl,-Map=${STM32_PROJECT_NAME}.map -Wl,--gc-sections -static -Wl,--no-warn-rwx-segment
    -Wl,--start-group -lc -lm -Wl,--end-group -mtune=${STM32_PROJECT_CPU} -Wl,--print-memory-usage
)


add_link_options(${STM32_LIB_EXTRA_LIBS})
add_definitions(
    ${STM32_EXTRA_DEFINITIONS}
    -D${STM32_PROJECT_DEVICE_FAMILY}=1
    -D${STM32_PROJECT_DEVICE}=1
)
include_directories(${STM32_PROJECT_HEADERS_DIR})