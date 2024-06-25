# Veelgestelde Vragen over Assembly Language en Gerelateerde Tools

## 1. Wat is de assembly language?
Assembly language is een low-level programmeertaal die nauw aansluit bij de machine-instructies van een computer. Het vertaalt instructies naar een formaat dat direct door de processor kan worden uitgevoerd. Elke instructie in assembly language correspondeert met een specifieke machinecode instructie.

## 2. Wat doet de nasm tool?
NASM (Netwide Assembler) is een assembler voor de x86-architectuur. Het vertaalt assembly code naar machinecode die direct door een computer kan worden uitgevoerd.

## 3. Waar gebruik je qemu voor?
QEMU is een open-source emulator en virtualizer. Het kan een volledige computer of specifieke hardware componenten emuleren, waardoor je een besturingssysteem of software op een andere architectuur kunt draaien dan waarvoor ze oorspronkelijk ontworpen zijn.

## 4. Waarom start een PC in 16-bit mode?
Een PC start in 16-bit mode vanwege de compatibiliteit met oudere BIOS. Bij het opstarten volgt de processor de opstartprocedure zoals gedefinieerd door de originele IBM PC architectuur.

## 5. Starten alle PC’s in 16-bit mode?
Nee. Nieuwere PC’s die een 64-bit cpu hebben kunnen starten in 64-bit mode.

## 6. Wat is een interrupt call?
Een interrupt call is een signaal dat een bepaald programma onderbreekt om een specifieke service routine uit te voeren. Dit kan een hardware-interrupt zijn, zoals een toetsenbordactie, of een software-interrupt die door een programma wordt gegenereerd om bijvoorbeeld systeembronnen aan te vragen of andere functies uit te voeren.

## 7. Welke interrupt calls zijn er beschikbaar voor gebruikersinvoer?
Enkele van de belangrijkste interrupt calls voor gebruikersinvoer zijn:
-	INT 9 - Keyboard interrupt
-	INT 16 - Keyboard interrupt for older systems
-	INT 33h - Mouse interrupt
-	INT 74h - Serial port interrupt
