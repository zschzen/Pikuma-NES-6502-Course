;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Constants for PPU registers mapped from addresses $2000 to $2007
;; These registers control various aspects of the NES Picture Processing Unit (PPU)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PPU_CTRL   = $2000           ; Configures NMI, sprite size, background pattern table, etc.
PPU_MASK   = $2001           ; Controls color emphasis, sprite visibility, background visibility, etc.
PPU_STATUS = $2002           ; Read-only, returns the status of the PPU, including v-blank and sprite overflow
OAM_ADDR   = $2003           ; Sets the address in the Object Attribute Memory (OAM) to write data to
OAM_DATA   = $2004           ; Writes data to the Object Attribute Memory (OAM) for sprite information
PPU_SCROLL = $2005           ; Controls the scroll position of the background in the PPU
PPU_ADDR   = $2006           ; Sets the VRAM address for subsequent data reads/writes to $2007
PPU_DATA   = $2007           ; Read/write data to/from VRAM (Video RAM) based on the address set in $2006

