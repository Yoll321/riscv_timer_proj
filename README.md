Задание по Bare Metal программированию на RISC-V (QEMU)
========================================================

Цель
----
Реализовать простую программу на bare-metal RISC-V под QEMU, которая использует Machine Timer и UART
для отсчёта времени и вывода данных в консоль.

Что нужно реализовать
---------------------
1. Настроить Machine Timer (`mtime`, `mtimecmp`) для генерации прерываний каждую секунду.
2. Реализовать обработчик прерывания, который уменьшает значение таймера (от 10 до 0).
3. Каждую секунду выводить текущее значение в UART.
4. После достижения 0 – вывести сообщение “Time’s up!” в консоль.

Требования
----------
- Используется эмуляция QEMU: 
    qemu-system-riscv32 -machine virt -nographic -kernel your_prog.elf
- Написано на C или C с вставками ассемблера
- Без libc, инициализация стека вручную

Полезные адреса
---------------
UART0      = 0x10000000  
CLINT_BASE = 0x02000000  
MTIME      = *(uint64_t *)(CLINT_BASE + 0xBFF8)  
MTIMECMP   = *(uint64_t *)(CLINT_BASE + 0x4000)

Минимальные файлы проекта
-------------------------
- main.c — основная логика  
- start.S — инициализация системы  
- link.ld — линковочный скрипт  
- Makefile — сборка

Документация
------------
- RISC-V Privileged Spec: https://github.com/riscv/riscv-isa-manual/releases  
- QEMU virt machine source: https://github.com/qemu/qemu/blob/master/hw/riscv/virt.c
