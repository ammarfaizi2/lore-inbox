Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRC3Joj>; Fri, 30 Mar 2001 04:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRC3Job>; Fri, 30 Mar 2001 04:44:31 -0500
Received: from linux.kappa.ro ([194.102.255.131]:24506 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S131246AbRC3JoO>;
	Fri, 30 Mar 2001 04:44:14 -0500
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Fri, 30 Mar 2001 12:43:19 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: OOPS: Resend - more info
Message-ID: <20010330124319.C20854@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I hope that this time it will be clear enough to extract some info. I got
the full OOPS and decoded it. Please find attached the decoded OOPS and
other info.


-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=aa


[1.] One line summary of the problem:    
Kernel OOPS. Machine hanged under heavy load.

[2.] Full description of the problem/report:
The computer that is handling our e-mail hanged with an OOPS. This is the fifth time.
I hope that we'll get it.

[3.] Keywords (i.e., modules, networking, kernel):
kernel, networking

[4.] Kernel version (from /proc/version):
Linux version 2.4.3-pre8 (root@k) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Mon Mar 26 14:39:35 EEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

See the other attached file.

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux k 2.4.3-pre8 #1 SMP Mon Mar 26 14:39:35 EEST 2001 i686 unknown
 
 Gnu C                  egcs-2.91.66
 Gnu make               3.79
 binutils               2.10.1.0.2
 util-linux             2.10o
 modutils               2.4.2
 e2fsprogs              1.19
 PPP                    2.3.11
 Linux C Library        2.2.1
 ldd: version 1.9.9
 Procps                 2.0.7
 Net-tools              1.57
 Kbd                    0.99
 Sh-utils               2.0
 Modules Loaded         


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 736.019
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1468.00

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 736.019
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1471.28

[7.3.] Module information (from /proc/modules):
none
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-907f : Silicon Integrated Systems [SiS] 86C326
a000-a00f : VIA Technologies, Inc. Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
ac00-ac07 : Triones Technologies, Inc. HPT366
b000-b003 : Triones Technologies, Inc. HPT366
b400-b407 : Triones Technologies, Inc. HPT366
b800-b803 : Triones Technologies, Inc. HPT366
bc00-bcff : Triones Technologies, Inc. HPT366
  bc00-bc07 : ide2
  bc08-bc0f : ide3
  bc10-bcff : HPT370
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139
  c000-c0ff : 8139too

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-0021da15 : Kernel code
  0021da16-002817bf : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d4000000-d5ffffff : PCI Bus #01
  d5000000-d500ffff : Silicon Integrated Systems [SiS] 86C326
d7000000-d77fffff : PCI Bus #01
  d7000000-d77fffff : Silicon Integrated Systems [SiS] 86C326
d7800000-d78000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d7800000-d78000ff : 8139too
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR
- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode
])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR
- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d7000000-d77fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR
- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master
 SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR
- <PERR-
        Latency: 32
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR
- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 03)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR
- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ac00 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b800 [size=4]
        Region 4: I/O ports at bc00 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR
- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at d7800000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b) (prog-if 00 
[VGA])
        Subsystem: Palit Microsystems Inc. SiS6326 GUI Accelerator
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR
- <PERR-
        Latency: 32 (500ns min)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at d7000000 (32-bit, prefetchable) [size=8M]
        Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at 9000 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 1.0
                Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>



[7.6.] SCSI information (from /proc/scsi/scsi)
no scsi adapters

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
This is a very loaded server running lots of apache processes and sendmail.

[X.] Other notes, patches, fixes, workarounds:

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops-decoded.txt"

ksymoops 2.3.5 on i686 2.4.3-pre8.  Options used
     -v /usr/src/linux-2.4.3-pre8/vmlinux (specified)
     -k /proc/ksyms (specified)
     -L (specified)
     -o /lib/modules/2.4.3-pre8 (specified)
     -m /boot/System.map-2.4.3-pre8 (specified)

No modules in ksyms, skipping objects
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(alloc_etherdev) not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(ether_setup) not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(init_etherdev) not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(register_netdev) not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(unregister_netdev) not found in vmlinux.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual adress 00000004
*pde =  00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c011c385>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: dbfe1904   ebx: dc3ae684   ecx: 00000202   edx: 00000000
esi: c02d846c   edi: dc3ae684   ebp: dc3ae640   esp: c189bdd4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c189b000)
Stack: c189a000 c02d846c c020488a dc3ae684 c02d846c c189a000 d3acf874 00000007
       c0205000 dc3ae640 00001770 dc3ae640 df7cc280 c027ffc0 c189becc c0204218
       dc3ae640 d3acf860 00000028 00000000 c189bebc c02fa2e0 c01dff74 00000000
Call Trace: [<c020488a>] [<c0205000>] [<c0204218>] [<c01dff74>] [<eeff66c2>] [<c01da8e0>] [<c01dff74>]
            [<c01dab77>] [<c01dff74>] [<c01dfe3e>] [<c01dff74>] [<e0800038>] [<e0800037>] [<c01d5613>] [<c01192ea>]
            [<c01089c7>] [<c01051c0>] [<c01051c0>] [<c01070c8>] [<c01051c0>] [<c01051c0>] [<c0100018>] [<c01051ec>]
            [<c010524e>] [<c01cebe1>] [<c01a6646>]
Code: 89 5a 04 89 13 89 43 04 89 18 c6 05 a8 e3 26 c0 01 51 9d eb

>>EIP; c011c385 <add_timer+b1/e8>   <=====
Trace; c020488a <ip_ct_refresh+62/80>
Trace; c0205000 <tcp_packet+164/174>
Trace; c0204218 <ip_conntrack_in+298/324>
Trace; c01dff74 <ip_rcv_finish+0/208>
Trace; eeff66c2 <END_OF_CODE+2ecf9e0e/????>
Trace; c01da8e0 <nf_iterate+30/7c>
Trace; c01dff74 <ip_rcv_finish+0/208>
Trace; c01dab77 <nf_hook_slow+6f/108>
Trace; c01dff74 <ip_rcv_finish+0/208>
Trace; c01dfe3e <ip_rcv+33a/37c>
Trace; c01dff74 <ip_rcv_finish+0/208>
Trace; e0800038 <END_OF_CODE+20503784/????>
Trace; e0800037 <END_OF_CODE+20503783/????>
Trace; c01d5613 <net_rx_action+17b/274>
Trace; c01192ea <do_softirq+56/84>
Trace; c01089c7 <do_IRQ+db/ec>
Trace; c01051c0 <default_idle+0/34>
Trace; c01051c0 <default_idle+0/34>
Trace; c01070c8 <ret_from_intr+0/20>
Trace; c01051c0 <default_idle+0/34>
Trace; c01051c0 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c01051ec <default_idle+2c/34>
Trace; c010524e <cpu_idle+3a/50>
Trace; c01cebe1 <vgacon_cursor+1e9/1f4>
Trace; c01a6646 <set_cursor+6e/84>
Code;  c011c385 <add_timer+b1/e8>
0000000000000000 <_EIP>:
Code;  c011c385 <add_timer+b1/e8>   <=====
   0:   89 5a 04                  mov    %ebx,0x4(%edx)   <=====
Code;  c011c388 <add_timer+b4/e8>
   3:   89 13                     mov    %edx,(%ebx)
Code;  c011c38a <add_timer+b6/e8>
   5:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c011c38d <add_timer+b9/e8>
   8:   89 18                     mov    %ebx,(%eax)
Code;  c011c38f <add_timer+bb/e8>
   a:   c6 05 a8 e3 26 c0 01      movb   $0x1,0xc026e3a8
Code;  c011c396 <add_timer+c2/e8>
  11:   51                        push   %ecx
Code;  c011c397 <add_timer+c3/e8>
  12:   9d                        popf   
Code;  c011c398 <add_timer+c4/e8>
  13:   eb 00                     jmp    15 <_EIP+0x15> c011c39a <add_timer+c6/e8>

Kernel panic: Aiee, killing interrupt handler!

5 warnings issued.  Results may not be reliable.

--82I3+IH0IqGh5yIs--
