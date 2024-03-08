include(drivers/stm32f0xx/driver_hal)

set(STM32LIB_SOURCE_FILES ${STM32LIB_SOURCE_FILES}
    ${CMAKE_CURRENT_LIST_DIR}/../../Src/stm32f0xx/stm32f0xx_hal_i2c.c
    ${CMAKE_CURRENT_LIST_DIR}/../../Src/stm32f0xx/stm32f0xx_hal_i2c_ex.c
)
