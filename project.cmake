set(STM32_PROJECT_NAME "stm32evk")
set(STM32_PROJECT_VERSION 1.0.0)
set(STM32_PROJECT_DEVICE "STM32F030x6")
set(STM32_PROJECT_DEVICE_FAMILY "STM32F0")
set(STM32_JLINK_DEVICE "STM32F030K6")
set(STM32_PROJECT_CPU cortex-m0)

set(STM32_LIB_EXTRA_SOURCES)
set(STM32_LIB_EXTRA_HEADERS)
set(STM32_LIB_EXTRA_LIBS)

include(lib/Drivers/stm32_framework.cmake)
include(CMSIS/component_cmsis)
include(CMSIS/Device/cmsis_st_stm32f0xx)
include(drivers/stm32f0xx/drivers_all)




set(STM32_PROJECT_LDSCRIPT
    src/STM32F030K6TX_FLASH.ld
)

set(STM32_PROJECT_SOURCES
    src/Src/system_stm32f0xx.c
    src/Src/sysmem.c
    src/Src/syscalls.c
    src/Src/stm32f0xx_it.c
    src/Src/stm32f0xx_hal_msp.c
    src/Src/main.c
    src/Startup/startup_stm32f030k6tx.s
)

set(STM32_PROJECT_HEADERS_DIR
    src/Inc
)


set(STM32_EXTRA_DEFINITIONS
    -DDEBUG=1
)