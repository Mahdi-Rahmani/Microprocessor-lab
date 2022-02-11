;/*****************************************************************************
; * @file:    startup_SAM3XA.s
; * @purpose: CMSIS Cortex-M3 Core Device Startup File 
; *           for the Atmel SAM3XA Device Series 
; * @version: V1.20
; * @date:    14. December 2015
; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------
; *
; * Copyright (C) 2010-2013 ARM Limited. All rights reserved.
; * ARM Limited (ARM) is supplying this software for use with Cortex-M3 
; * processor based microcontrollers.  This file can be freely distributed 
; * within development tools that are supporting such ARM based processors. 
; *
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; *****************************************************************************/


; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000200

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ;  0: Top of Stack
                DCD     Reset_Handler             ;  1: Reset Handler
                DCD     NMI_Handler               ;  2: NMI Handler
                DCD     HardFault_Handler         ;  3: Hard Fault Handler
                DCD     MemManage_Handler         ;  4: MPU Fault Handler
                DCD     BusFault_Handler          ;  5: Bus Fault Handler
                DCD     UsageFault_Handler        ;  6: Usage Fault Handler
                DCD     0                         ;  7: Reserved
                DCD     0                         ;  8: Reserved
                DCD     0                         ;  9: Reserved
                DCD     0                         ; 10: Reserved
                DCD     SVC_Handler               ; 11: SVCall Handler
                DCD     DebugMon_Handler          ; 12: Debug Monitor Handler
                DCD     0                         ; 13: Reserved
                DCD     PendSV_Handler            ; 14: PendSV Handler
                DCD     SysTick_Handler           ; 15: SysTick Handler

                ; External Interrupts
                DCD     SUPC_IRQHandler           ;  0: Supply Controller (SUPC)
                DCD     RSTC_IRQHandler           ;  1: Reset Controller (RSTC)
                DCD     RTC_IRQHandler            ;  2: Real Time Clock (RTC)
                DCD     RTT_IRQHandler            ;  3: Real Time Timer (RTT)
                DCD     WDT_IRQHandler            ;  4: Watchdog Timer (WDT)
                DCD     PMC_IRQHandler            ;  5: Power Management Controller (PMC)
                DCD     EFC0_IRQHandler           ;  6: Enhanced Flash Controller 0 (EFC0)
                DCD     EFC1_IRQHandler           ;  7: Enhanced Flash Controller 1 (EFC1)
                DCD     UART_IRQHandler           ;  8: Universal Asynchronous Receiver Transceiver (UART)
                DCD     SMC_IRQHandler            ;  9: Static Memory Controller (SMC)
                DCD     SDRAMC_IRQHandler         ; 10: Synchronous Dynamic RAM Controller (SDRAMC)
                DCD     PIOA_IRQHandler           ; 11: Parallel I/O Controller A + 16: (PIOA)
                DCD     PIOB_IRQHandler           ; 12: Parallel I/O Controller B (PIOB)
                DCD     PIOC_IRQHandler           ; 13: Parallel I/O Controller C (PIOC)
                DCD     PIOD_IRQHandler           ; 14: Parallel I/O Controller D (PIOD)
                DCD     PIOE_IRQHandler           ; 15: Parallel I/O Controller E (PIOE)
                DCD     PIOF_IRQHandler           ; 16: Parallel I/O Controller F (PIOF)
                DCD     USART0_IRQHandler         ; 17: USART 0 (USART0)
                DCD     USART1_IRQHandler         ; 18: USART 1 (USART1)
                DCD     USART2_IRQHandler         ; 19: USART 2 (USART2)
                DCD     USART3_IRQHandler         ; 20: USART 3 (USART3)
                DCD     HSMCI_IRQHandler          ; 21: Multimedia Card Interface (HSMCI)
                DCD     TWI0_IRQHandler           ; 22: Two-Wire Interface 0 (TWI0)
                DCD     TWI1_IRQHandler           ; 23: Two-Wire Interface 1 (TWI1)
                DCD     SPI0_IRQHandler           ; 24: Serial Peripheral Interface (SPI0)
                DCD     SPI1_IRQHandler           ; 25: Serial Peripheral Interface (SPI1)
                DCD     SSC_IRQHandler            ; 26: Synchronous Serial Controller (SSC)
                DCD     TC0_IRQHandler            ; 27: Timer Counter 0 (TC0)
                DCD     TC1_IRQHandler            ; 28: Timer Counter 1 (TC1)
                DCD     TC2_IRQHandler            ; 29: Timer Counter 2 (TC2)
                DCD     TC3_IRQHandler            ; 30: Timer Counter 3 (TC3)
                DCD     TC4_IRQHandler            ; 31: Timer Counter 4 (TC4)
                DCD     TC5_IRQHandler            ; 32: Timer Counter 5 (TC5)
                DCD     TC6_IRQHandler            ; 33: Timer Counter 6 (TC6)
                DCD     TC7_IRQHandler            ; 34: Timer Counter 7 (TC7)
                DCD     TC8_IRQHandler            ; 35: Timer Counter 8 (TC8)
                DCD     PWM_IRQHandler            ; 36: Pulse Width Modulation Controller (PWM)
                DCD     ADC_IRQHandler            ; 37: ADC Controller (ADC)
                DCD     DACC_IRQHandler           ; 38: DAC Controller (DACC)
                DCD     DMAC_IRQHandler           ; 39: DMA Controller (DMAC)
                DCD     UOTGHS_IRQHandler         ; 40: USB OTG High Speed (UOTGHS)
                DCD     TRNG_IRQHandler           ; 41: True Random Number Generator (TRNG)
                DCD     EMAC_IRQHandler           ; 42: Ethernet MAC (EMAC)
                DCD     CAN0_IRQHandler           ; 43: CAN Controller 0 (CAN0)
                DCD     CAN1_IRQHandler           ; 44: CAN Controller 1 (CAN1)

                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  SystemInit
                IMPORT  __main
                ;LDR     R0, =SystemInit
                ;BLX     R0
                LDR     R0, =__main
                BX      R0
                ENDP


; Dummy Exception Handlers (infinite loops which can be modified)                

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  SUPC_IRQHandler           [WEAK]
                EXPORT  RSTC_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  RTT_IRQHandler            [WEAK]
                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  PMC_IRQHandler            [WEAK]
                EXPORT  EFC0_IRQHandler           [WEAK]
                EXPORT  EFC1_IRQHandler           [WEAK]
                EXPORT  UART_IRQHandler           [WEAK]
                EXPORT  SMC_IRQHandler            [WEAK]
                EXPORT  SDRAMC_IRQHandler         [WEAK]
                EXPORT  PIOA_IRQHandler           [WEAK]
                EXPORT  PIOB_IRQHandler           [WEAK]
                EXPORT  PIOC_IRQHandler           [WEAK]
                EXPORT  PIOD_IRQHandler           [WEAK]
                EXPORT  PIOE_IRQHandler           [WEAK]
                EXPORT  PIOF_IRQHandler           [WEAK]
                EXPORT  USART0_IRQHandler         [WEAK]
                EXPORT  USART1_IRQHandler         [WEAK]
                EXPORT  USART2_IRQHandler         [WEAK]
                EXPORT  USART3_IRQHandler         [WEAK]
                EXPORT  HSMCI_IRQHandler          [WEAK]
                EXPORT  TWI0_IRQHandler           [WEAK]
                EXPORT  TWI1_IRQHandler           [WEAK]
                EXPORT  SPI0_IRQHandler           [WEAK]
                EXPORT  SPI1_IRQHandler           [WEAK]
                EXPORT  SSC_IRQHandler            [WEAK]
                EXPORT  TC0_IRQHandler            [WEAK]
                EXPORT  TC1_IRQHandler            [WEAK]
                EXPORT  TC2_IRQHandler            [WEAK]
                EXPORT  TC3_IRQHandler            [WEAK]
                EXPORT  TC4_IRQHandler            [WEAK]
                EXPORT  TC5_IRQHandler            [WEAK]
                EXPORT  TC6_IRQHandler            [WEAK]
                EXPORT  TC7_IRQHandler            [WEAK]
                EXPORT  TC8_IRQHandler            [WEAK]
                EXPORT  PWM_IRQHandler            [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  DACC_IRQHandler           [WEAK]
                EXPORT  DMAC_IRQHandler           [WEAK]
                EXPORT  UOTGHS_IRQHandler         [WEAK]
                EXPORT  TRNG_IRQHandler           [WEAK]
                EXPORT  EMAC_IRQHandler           [WEAK]
                EXPORT  CAN0_IRQHandler           [WEAK]
                EXPORT  CAN1_IRQHandler           [WEAK]

SUPC_IRQHandler
RSTC_IRQHandler
RTC_IRQHandler
RTT_IRQHandler
WDT_IRQHandler
PMC_IRQHandler
EFC0_IRQHandler
EFC1_IRQHandler
UART_IRQHandler
SMC_IRQHandler
SDRAMC_IRQHandler
PIOA_IRQHandler
PIOB_IRQHandler
PIOC_IRQHandler
PIOD_IRQHandler
PIOE_IRQHandler
PIOF_IRQHandler
USART0_IRQHandler
USART1_IRQHandler
USART2_IRQHandler
USART3_IRQHandler
HSMCI_IRQHandler
TWI0_IRQHandler
TWI1_IRQHandler
SPI0_IRQHandler
SPI1_IRQHandler
SSC_IRQHandler
TC0_IRQHandler
TC1_IRQHandler
TC2_IRQHandler
TC3_IRQHandler
TC4_IRQHandler
TC5_IRQHandler
TC6_IRQHandler
TC7_IRQHandler
TC8_IRQHandler
PWM_IRQHandler
ADC_IRQHandler
DACC_IRQHandler
DMAC_IRQHandler
UOTGHS_IRQHandler
TRNG_IRQHandler
EMAC_IRQHandler
CAN0_IRQHandler
CAN1_IRQHandler
                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB
                
                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit
                
                ELSE
                
                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
