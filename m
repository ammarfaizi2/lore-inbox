Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTBCNqa>; Mon, 3 Feb 2003 08:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTBCNqa>; Mon, 3 Feb 2003 08:46:30 -0500
Received: from [195.20.32.236] ([195.20.32.236]:31927 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S266318AbTBCNqU>;
	Mon, 3 Feb 2003 08:46:20 -0500
Date: Mon, 3 Feb 2003 13:53:52 +0100
From: Alexander Kellett <lypanov@kde.org>
To: saurabh khanna <linux_guyus@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030203125352.GA5925@groucho.verza.com>
Mail-Followup-To: saurabh khanna <linux_guyus@rediffmail.com>,
	linux-kernel@vger.kernel.org
References: <20030131184605.22113.qmail@webmail29.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131184605.22113.qmail@webmail29.rediffmail.com>
User-Agent: Mutt/1.4i
Disclaimer: My opinions do not necessarily represent those of my employer
Copyright: Copyright 2003 Alexander Kellett - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hiya,

unfortunately this list isn't for such problems and it
would be better to contact your distribution or the various
forums it has. try google.

/me wonders again why this list isn't called linux-kernel-dev@...

Alex

On Fri, Jan 31, 2003 at 06:46:05PM -0000, saurabh  khanna wrote:
> Problem: My xwindows did not open and my sound card don't work.
> 
> Xwindows:
> I am a novice. I am using redhat linux 8. It detects my graphics 
> card
> correctly but when i tried to open xwindows, my system hangs.
> 
> Sound:
> Linux has detected my sound card once but not configured it and 
> after
> that nor it is working nither it is detected by my linux.
> 
> GRUB:
> Also, i can boot my linux through LILO only. GRUB wont work, it 
> gives
> error "Not enough memory".
> 
> I have re-installed linux on my computer but the problem 
> remains.
> All other detailes are follows.
> 
> Kernel version:
> Linux version 2.4.18-14 (bhcompile@astest.test.redhat.com)
> (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7))
> #1 Wed Sep 4 12:13:11 EDT 2002
> 
> 
> Commond which triggers the problem:
> startx
> 
> Processor information:
> processor	: 0
> 
> vendor_id	: AuthenticAMD
> 
> cpu family	: 6
> 
> model		: 6
> 
> model name	: AMD Athlon(TM) XP 1700+
> 
> stepping	: 2
> 
> cpu MHz		: 1469.861
> 
> cache size	: 256 KB
> 
> fdiv_bug	: no
> 
> hlt_bug		: no
> 
> f00f_bug	: no
> 
> coma_bug	: no
> 
> fpu		: yes
> 
> fpu_exception	: yes
> 
> cpuid level	: 1
> 
> wp		: yes
> 
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> 
> bogomips	: 2920.57
> 
> 
> 
> Module information:
> nls_iso8859-1           3516   1 (autoclean)
> 
> nls_cp437               5116   1 (autoclean)
> 
> vfat                   13084   1 (autoclean)
> 
> fat                    38744   0 (autoclean)
> [vfat]
> autofs                 13348   0 (autoclean) (unused)
> 
> ipt_REJECT              3736   2 (autoclean)
> 
> iptable_filter          2412   1 (autoclean)
> 
> ip_tables              14840   2 [ipt_REJECT iptable_filter]
> 
> mousedev                5524   0 (unused)
> 
> keybdev                 2976   0 (unused)
> 
> hid                    22244   0 (unused)
> 
> input                   5888   0 [mousedev keybdev hid]
> 
> usb-ohci               21288   0 (unused)
> 
> usbcore                77056   1 [hid usb-ohci]
> 
> ext3                   70400   1
> 
> jbd                    52212   1 [ext3]
> 
> 
> 
> Loaded driver and hardware information:
> 0000-001f : dma
> 1
> 0020-003f : pic
> 1
> 0040-005f : timer
> 
> 0060-006f : keyboard
> 
> 0070-007f : rtc
> 
> 0080-008f : dma page reg
> 
> 00a0-00bf : pic
> 2
> 00c0-00df : dma
> 2
> 00f0-00ff : fpu
> 
> 01f0-01f7 : ide
> 0
> 02f8-02ff : serial(auto)
> 
> 03c0-03df : vga+
> 
> 03f6-03f6 : ide
> 0
> 03f8-03ff : serial(auto)
> 
> 0cf8-0cff : PCI conf
> 1
> 5000-500f : PCI device 10de:01b4 (nVidia Corporation)
> 
> 5100-511f : PCI device 10de:01b4 (nVidia Corporation)
> 
> 5500-550f : PCI device 10de:01b4 (nVidia Corporation)
> 
> a800-a80f : nVidia Corporation nForce IDE
> 
> a800-a807 : ide0
> 
> a808-a80f : ide1
> 
> b000-bfff : PCI Bus #01
> 
> b800-b807 : Rockwell International HCF 56k Data/Fax/Voice/Spkp 
> (w/Handset) Modem
> 
> d800-d807 : PCI device 10de:01c3 (nVidia Corporation)
> 
> e000-e07f : PCI device 10de:01b1 (nVidia Corporation)
> 
> e100-e1ff : PCI device 10de:01b1 (nVidia Corporation)
> 
> 00000000-0007ffff : System RAM
> 
> 0009fc00-0009ffff : reserved
> 
> 000a0000-000bffff : Video RAM area
> 
> 000c0000-000c7fff : Video ROM
> 
> 000f0000-000fffff : System ROM
> 
> 00100000-06febfff : System RAM
> 
> 00100000-00247f2e : Kernel code
> 
> 00247f2f-0033ed03 : Kernel data
> 
> 06fec000-06feefff : ACPI Tables
> 
> 06fef000-06ffefff : reserved
> 
> 06fff000-06ffffff : ACPI Non-volatile Storage
> 
> eb000000-ec7fffff : PCI Bus #02
> 
> eb000000-ebffffff : nVidia Corporation GeForce2 Integrated GPU
> 
> ec800000-ecffffff : PCI Bus #01
> 
> ec800000-ec80ffff : Rockwell International HCF 56k 
> Data/Fax/Voice/Spkp (w/Handset) Modem
> 
> ed000000-ed000fff : PCI device 10de:01b1 (nVidia Corporation)
> 
> ed800000-ed87ffff : PCI device 10de:01b0 (nVidia Corporation)
> 
> ee000000-ee0003ff : PCI device 10de:01c3 (nVidia Corporation)
> 
> ee800000-ee800fff : PCI device 10de:01c2 (nVidia Corporation)
> 
> ee800000-ee800fff : usb-ohci
> e
> f000000-ef000fff : PCI device
> 10de:01c2 (nVidia Corporation)
> 
> ef000000-ef000fff : usb-ohci
> e
> ff00000-f7ffffff : PCI Bus #02
> 
> f0000000-f7ffffff : nVidia Corporation GeForce2 Integrated GPU
> 
> f8000000-fbffffff : PCI device
> 10de:01a4 (nVidia Corporation)
> 
> fec00000-fec00fff : reserved
> 
> fee00000-fee00fff : reserved
> 
> ffff0000-ffffffff : reserved
> 
> 
> PCI information:
> 00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev 
> b2)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: [40] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x1
> 	Capabilities: [60] #08 [2001]
> 
> 00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory 
> Controller (rev b2)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory 
> Controller (rev b2)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev 
> b2)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 
> 00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev 
> c3)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [50] #08 [01e1]
> 
> 00:01.1 SMBus: nVidia Corporation nForce PCI System Management 
> (rev c1)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at 5000 [size=16]
> 	Region 1: I/O ports at 5500 [size=16]
> 	Region 2: I/O ports at 5100 [size=32]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:02.0 USB Controller: nVidia Corporation: Unknown device 01c2 
> (rev c3) (prog-if 10 [OHCI])
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at ef000000 (32-bit, non-prefetchable) 
> [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:03.0 USB Controller: nVidia Corporation: Unknown device 01c2 
> (rev c3) (prog-if 10 [OHCI])
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at ee800000 (32-bit, non-prefetchable) 
> [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:04.0 Ethernet controller: nVidia Corporation: Unknown device 
> 01c3 (rev c2)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (250ns min, 5000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at ee000000 (32-bit, non-prefetchable) 
> [size=1K]
> 	Region 1: I/O ports at d800 [size=8]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:05.0 Multimedia audio controller: nVidia Corporation: Unknown 
> device 01b0 (rev c2)
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (250ns min, 3000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at ed800000 (32-bit, non-prefetchable) 
> [size=512K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:06.0 Multimedia audio controller: nVidia Corporation nForce 
> Audio (rev c2)
> 	Subsystem: nVidia Corporation: Unknown device 8384
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (500ns min, 1250ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at e100 [size=256]
> 	Region 1: I/O ports at e000 [size=128]
> 	Region 2: Memory at ed000000 (32-bit, non-prefetchable) 
> [disabled] [size=4K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge 
> (rev c2) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000b000-0000bfff
> 	Memory behind bridge: ec800000-ecffffff
> 	Prefetchable memory behind bridge: f8000000-f7ffffff
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 
> 00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3) 
> (prog-if 8a [Master SecP PriP])
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0 (750ns min, 250ns max)
> 	Region 4: I/O ports at a800 [size=16]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge 
> (rev b2) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
> 	I/O behind bridge: 0000a000-00009fff
> 	Memory behind bridge: eb000000-ec7fffff
> 	Prefetchable memory behind bridge: eff00000-f7ffffff
> 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
> 
> 01:08.0 Communication controller: Rockwell International HCF 56k 
> Data/Fax/Voice/Spkp (w/Handset) Modem (rev 01)
> 	Subsystem: Rockwell International HCF 56k Data/Fax/Voice/Spkp 
> (w/Handset) Modem
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at ec800000 (32-bit, non-prefetchable) 
> [size=64K]
> 	Region 1: I/O ports at b800 [size=8]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
> 
> 02:00.0 VGA compatible controller: nVidia Corporation NV15 
> [GeForce2 - nForce GPU] (rev b1) (prog-if 00 [VGA])
> 	Subsystem: nVidia Corporation: Unknown device 0c11
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (1250ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at eb000000 (32-bit, non-prefetchable) 
> [size=16M]
> 	Region 1: Memory at f0000000 (32-bit, prefetchable) 
> [size=128M]
> 	Expansion ROM at efff0000 [disabled] [size=64K]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [44] AGP version 2.0
> 		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x4
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 
> 
> XF86Config:
> 
> # File generated by anaconda.
> 
> Section "ServerLayout"
>         Identifier     "Anaconda Configured"
>         Screen      0  "Screen0" 0 0
>         InputDevice    "Mouse0" "CorePointer"
> 	InputDevice	"Mouse1" "SendCoreEvents"
>         InputDevice    "Keyboard0" "CoreKeyboard"
> EndSection
> 
> Section "Files"
> 
> # The location of the RGB database.  Note, this is the name of 
> the
> # file minus the extension (like ".txt" or ".db").  There is 
> normally
> # no need to change the default.
> 
>     RgbPath	"/usr/X11R6/lib/X11/rgb"
> 
> # Multiple FontPath entries are allowed (they are concatenated 
> together)
> # By default, Red Hat 6.0 and later now use a font server 
> independent of
> # the X server to render fonts.
> 
>     FontPath   "unix/:7100"
> 
> EndSection
> 
> Section "Module"
>         Load  "dbe"
>         Load  "extmod"
> 	Load  "fbdevhw"
> 	Load  "dri"
>         Load  "glx"
>         Load  "record"
>         Load  "freetype"
>         Load  "type1"
> EndSection
> 
> Section "InputDevice"
>         Identifier  "Keyboard0"
>         Driver      "keyboard"
> 
> #	Option	"AutoRepeat"	"500 5"
> 
> # when using XQUEUE, comment out the above line, and uncomment 
> the
> # following line
> #	Option	"Protocol"	"Xqueue"
> 
> # Specify which keyboard LEDs can be user-controlled (eg, with 
> xset(1))
> #	Option	"Xleds"		"1 2 3"
> 
> # To disable the XKEYBOARD extension, uncomment XkbDisable.
> #	Option	"XkbDisable"
> 
> # To customise the XKB settings to suit your keyboard, modify 
> the
> # lines below (which are the defaults).  For example, for a 
> non-U.S.
> # keyboard, you will probably want to use:
> #	Option	"XkbModel"	"pc102"
> # If you have a US Microsoft Natural keyboard, you can use:
> #	Option	"XkbModel"	"microsoft"
> #
> # Then to change the language, change the Layout setting.
> # For example, a german layout can be obtained with:
> #	Option	"XkbLayout"	"de"
> # or:
> #	Option	"XkbLayout"	"de"
> #	Option	"XkbVariant"	"nodeadkeys"
> #
> # If you'd like to switch the positions of your capslock and
> # control keys, use:
> #	Option	"XkbOptions"	"ctrl:swapcaps"
> 	Option	"XkbRules"	"xfree86"
> 	Option	"XkbModel"	"pc105"
> 	Option	"XkbLayout"	"us"
> 	#Option	"XkbVariant"	""
> 	#Option	"XkbOptions"	""
> EndSection
> 
> Section "InputDevice"
>         Identifier  "Mouse0"
>         Driver      "mouse"
>         Option      "Protocol" "PS/2"
>         Option      "Device" "/dev/psaux"
>         Option      "ZAxisMapping" "4 5"
>         Option      "Emulate3Buttons" "yes"
> EndSection
> 
> 
> Section "InputDevice"
> 	Identifier	"Mouse1"
> 	Driver		"mouse"
> 	Option		"Device"		"/dev/input/mice"
> 	Option		"Protocol"		"IMPS/2"
> 	Option		"Emulate3Buttons"	"no"
> 	Option		"ZAxisMapping"		"4 5"
> EndSection
> 
> 
> Section "Monitor"
>         Identifier   "Monitor0"
>         VendorName   "Monitor Vendor"
>         ModelName    "Monitor Model"
>         HorizSync   30-55
>         VertRefresh 50-120
>         Option "dpms"
> 
> 
> EndSection
> 
> Section "Device"
> 	# no known options
> 	Identifier   "NVIDIA GeForce 2 MX (generic)"
>         Driver       "nv"
>         VendorName   "NVIDIA GeForce 2 MX (generic)"
>         BoardName     "NVIDIA GeForce 2 MX (generic)"
> 
>         #BusID
> EndSection
> 
> Section "Screen"
> 	Identifier   "Screen0"
>         Device       "NVIDIA GeForce 2 MX (generic)"
>         Monitor      "Monitor0"
> 	DefaultDepth	16
> 
> 	Subsection "Display"
>         	Depth       16
>                 Modes       "1024x768" "800x600" "640x480"
> 	EndSubsection
> 
> EndSection
> 
> Section "DRI"
> 	Mode 0666
> EndSection
> 
> cmdline:
> auto BOOT_IMAGE=linux ro BOOT_FILE=/boot/vmlinuz-2.4.18-14 
> root=LABEL=/
> 
> 
> dma:
> 4: cascade
> 
> 
> intrrupts:
> CPU0
>   0:     337647          XT-PIC  timer
>   1:       2694          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:          0          XT-PIC  usb-ohci, usb-ohci
>   8:          1          XT-PIC  rtc
>  12:         20          XT-PIC  PS/2 Mouse
>  14:      27338          XT-PIC  ide0
> NMI:          0
> ERR:          2
> 
> 
> partitions:
> major minor  #blocks  name     rio rmerge rsect ruse wio wmerge 
> wsect wuse running use aveq
> 
>    3     0   39121488 hda 2567 4181 52107 22201 1417 1941 26952 
> 45880 -2 329576 7788488
>    3     1    5245191 hda1 9 43 104 109 0 0 0 0 0 109 109
>    3     2          1 hda2 0 0 0 0 0 0 0 0 0 0 0
>    3     5   10490413 hda5 9 43 104 95 0 0 0 0 0 95 95
>    3     6   11695288 hda6 50 43 145 214 7 1 8 95 0 230 310
>    3     7    8104761 hda7 9 43 104 132 0 0 0 0 0 132 132
>    3     8    3277228 hda8 2475 3966 51498 21527 1410 1940 26944 
> 45785 0 22394 67314
>    3     9     305203 hda9 9 25 104 56 0 0 0 0 0 56 56
> 
> 
> 
> My e-mail addresses are: linux_guyus@yahoo.com and 
> linux_guyus@rediff.com
> My postel address: 80, Ahilya Nagar Ext. Annapurna Road, Indore, 
> M.P.,
> India. PIN 452009
> please answer me soon.
> 		Thanking you.
> 			Saurabh Khanna.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

mvg,
Alex

-- 
"[...] Konqueror open source project. Weighing in at less than
            one tenth the size of another open source renderer"
Apple,  Jan 2003 (http://www.apple.com/safari/)
