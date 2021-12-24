#ifndef NVIC_H_
#define NVIC_H_

// NVIC DRIVER
// ARM NVIC MODULE
// STM32L432KC
// NVIC Description - is on pg 320
// NVIC Registers (Programming Manual) - is on 320
// STM32L552ZE-Q
// NVIC Description - is on pg 529
// NVIC Registers (Programming Manual) - is on 178

/* Nested vectored interrupt controller (NVIC) */
#if ARCHFLAG == 4 
    #define NVIC_32BIT      (uint32_t)32
    #define NVIC_8BIT       (uint32_t)8
    #define NVIC_ARRAYSIZE  (uint32_t)8
    #define NVIC_RESERVED   (uint32_t)24
    #define NVIC_IPR_SIZE   (uint32_t)60
#elif ARCHFLAG == 33
    #define NVIC_32BIT      (uint32_t)32
    #define NVIC_8BIT       (uint32_t)8
    #define NVIC_ARRAYSIZE  (uint32_t)16
    #define NVIC_RESERVED   (uint32_t)16
    #define NVIC_IPR_SIZE   (uint32_t)480
#else
    /* OVERRIDES TO SILENCE COMPILER ERRORS */
    #define NVIC_32BIT      (uint32_t)32
    #define NVIC_8BIT       (uint32_t)8
    #define NVIC_ARRAYSIZE  (uint32_t)8
    #define NVIC_RESERVED   (uint32_t)24
    #define NVIC_IPR_SIZE   (uint32_t)60
    #error Arch Flag Is Needed For NVIC.
#endif

typedef struct {
	volatile uint32_t   ISER[NVIC_ARRAYSIZE];		// Interrupt Set-Enable register
	volatile uint32_t   Reserved0[NVIC_RESERVED];	// Offset
	volatile uint32_t   ICER[NVIC_ARRAYSIZE]; 	    // Interrupt Clear-Enable register
	volatile uint32_t   Reserved1[NVIC_RESERVED];   // Offset
	volatile uint32_t   ISPR[NVIC_ARRAYSIZE];		// Interrupt Set-Pending Registers
	volatile uint32_t   Reserved2[NVIC_RESERVED];	// Offset
	volatile uint32_t   ICPR[NVIC_ARRAYSIZE];		// Interrupt Clear-Pending Registers
	volatile uint32_t   Reserved3[NVIC_RESERVED];	// Offset
	volatile uint32_t   IABR[NVIC_ARRAYSIZE];		// Interrupt Active Bit Registers
	volatile uint32_t   Reserved4[NVIC_RESERVED];	// Offset
    volatile uint32_t   ITNS[NVIC_ARRAYSIZE];		// Interrupt Target Non-Secure Registers
	volatile uint32_t   Reserved5[NVIC_RESERVED];	// Offset
	volatile uint8_t    IPR[NVIC_IPR_SIZE];		    // Interrupt Priority Registers
} NVIC_TypeDef;

/* Public Functions */
void nvic_enable_interrupt(NVIC_TypeDef *ptr, uint32_t irq_num);
void nvic_set_priority(NVIC_TypeDef *ptr, uint32_t irq_num, uint8_t priority, uint8_t sub_priority);

#endif /* NVIC_H_ */