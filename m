Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269512AbTGOSsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269514AbTGOSsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:48:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58271 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S269512AbTGOSq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:46:58 -0400
Message-ID: <3F144EF9.1090201@us.ibm.com>
Date: Tue, 15 Jul 2003 14:59:05 -0400
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs sitting in the NEW state for more than 28 days
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 127 bugs sitting in the NEW state for more than 28 days
that don't appear to have any activity. 40 of these bugs are owned
by bugme-janitors which are good candidates for anyone to work on.
Please check the bugs before working on them to see if they are
still available.

Kernel Bug Tracker: http://bugme.osdl.org

  49  Drivers    Console/   jsimmons@infradead.org
register_console() called in illegal context

  72  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

143  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated wi

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

191  Platform   i386       akpm@digeo.com
Panic on shutdown

199  Drivers    Flash/Me   dwmw2@infradead.org
compile failure on drivers/mtd/devices/blkmtd.c

205  Drivers    Console/   jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

207  Drivers    Console/   jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

220  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/AM53C974.c

236  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou <acc@cs.stanford.edu>

237  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

238  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds. From Andy 
Chou <acc@

239  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

243  Drivers    SCSI       andmike@us.ibm.com
possiblecpqfcTSworker.c out of bounds bug from Andy Chou 
<acc@cs.stanford.edu>

244  Drivers    SCSI       andmike@us.ibm.com
Possible uninitialised ptr scsi bug from Andy Chou <acc@cs.stanford.edu>

246  Drivers    SCSI       andmike@us.ibm.com
Possible missing assert in sym_malloc.c from acc@cs.stanford.edu

248  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Possible bug in sstfb.c from Stanford Checker

252  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds bug in sb_mixer.c from Stanford Checker

253  Drivers    Sound      bugme-janitors@lists.osdl.org
another possible out of bounds error in sb_mixer.c from Stanford Checker

254  Drivers    Sound      bugme-janitors@lists.osdl.org
One more possible out of bounds error in sb_mixer.c from Stanford Checker

263  Drivers    Console/   jsimmons@infradead.org
neofb null pointer dereference

267  Other      Other      fdavis@si.rr.com
ver_linux script fails to give module-init-tools version

273  Other      Modules    bugme-janitors@lists.osdl.org
initrd refuses to build on raid0 system

294  File Sys   devfs      bugme-janitors@lists.osdl.org
devfs_dealloc_unique_number() when not initialized

297  Platform   i386       mbligh@aracnet.com
Booting kernel 2.5.57 and higher ends with failure

301  IO/Stora   Block La   axboe@suse.de
ISA_DMA_THRESHOLD

320  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/ip2/i2lib.c

322  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/sx.c

329  Drivers    Input De   vojtech@suse.cz
wheel doesn't works on a usb mouse

332  Other      Other      bugme-janitors@lists.osdl.org
/etc/fstab LABEL for root partition not working

361  Drivers    Sound      bugme-janitors@lists.osdl.org
system hangs until keyrpress

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

371  Drivers    Other      bugme-janitors@lists.osdl.org
Badness in kobject_register at lib/kobject.c:152

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

384  Other      Modules    bugme-janitors@lists.osdl.org
2.5.62 make modules *.ko has no CRC

396  IO/Stora   Other      bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of ti

400  Other      Other      bugme-janitors@lists.osdl.org
Highpoint 370 triggers sleeping from illegal context debug code.

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1&2/ac test tree

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

452  File Sys   XFS        hch@sgi.com
Null pointer dereference in iget_locked

464  Power Ma   ACPI       andrew.grover@intel.com
2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned po

469  Networki   Other      acme@conectiva.com.br
/proc/net/dev byte counter wraps after 2^32

477  Networki   Other      acme@conectiva.com.br
mii-tool and ethtool require root to query

481  Drivers    USB        greg@kroah.com
Annoying full pathname prefixes before messages during boot.

487  Drivers    Other      bugme-janitors@lists.osdl.org
hisax.ko needs unknown symbol

489  Power Ma   ACPI       andrew.grover@intel.com
Boot hang on HP ZE4145

490  Drivers    Input De   vojtech@suse.cz
psmouse.c fails detecting Microsoft PS/2 wheel mice

496  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
No ataraid support in 2.5.65?

504  Drivers    Console/   jsimmons@infradead.org
Framebuffer Console corrupted

513  Drivers    USB        vojtech@suse.cz
Wacom driver doesn't work...

521  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
cdrecord fails to see drive caps consistently when using ide-cd

537  Drivers    Sound      bugme-janitors@lists.osdl.org
Alsa EMU10K1 Audigy

548  Power Ma   ACPI       andrew.grover@intel.com
ACPI Battery: Not working on Acer Aspire / VIA Chipset

556  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
dma not enabled for IDE hard drives

560  Drivers    Input De   vojtech@suse.cz
Wacom driver isn't working

576  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
IDE module loop

579  Drivers    ISDN       bugme-janitors@lists.osdl.org
isdn.ko needs unknown symbol group_send_sig_info

580  Memory M   Other      akpm@digeo.com
freeze after ~12 hours of operation, kswapd OOPS in logs

581  Drivers    SCSI       andmike@us.ibm.com
kernel panic in aha152x

588  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
2.5.67 won't get the real partition table for hdb

593  Other      Other      bugme-janitors@lists.osdl.org
fb.h has syntax errors

595  Alternat   ac         alan@lxorguk.ukuu.org.uk
ide-cd stops recognizing cd-rw, starting with 2.5.67-ac1.

599  Power Ma   ACPI       andrew.grover@intel.com
rtl8139 NIC don't work while CONFIG_ACPI=y

605  Power Ma   ACPI       andrew.grover@intel.com
ACPI S1: display blanking broken

609  Drivers    Input De   vojtech@suse.cz
Compilation error for adbhid.c [ppc]

611  Drivers    Sound      bugme-janitors@lists.osdl.org
keywest driver fails to compile due to i2c interface changes

612  IO/Stora   SCSI       andmike@us.ibm.com
aic7xxx driver hang

616  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
PCMCIA cards in cardbus sockets no longer suspended

617  IO/Stora   Other      bugme-janitors@lists.osdl.org
USB storage hangs mounting sony memory stick

621  File Sys   devfs      bugme-janitors@lists.osdl.org
oups while running mc, not able to run xterm nor kterm in xfree86

627  IO/Stora   DIO        akpm@digeo.com
[perf][rawiobench] serveraid adapter 2x slower on 2.5

628  Alternat   mjb        bhartner@us.ibm.com
Need configurable TASK_UNMAPPED_BASE per process

629  Alternat   mjb        bhartner@us.ibm.com
Configuring PAGE_OFFSET

643  Drivers    Console/   jsimmons@infradead.org
Problems when using both fbcon and vgacon

648  Other      Other      mochel@osdl.org
sysfs initialisation failure.

650  Drivers    Other      mochel@osdl.org
driver model needs easy way to create subdirs

652  File Sys   Other      bugme-janitors@lists.osdl.org
procfs: duplicated capacity entries in /proc/ide/hd*/

654  IO/Stora   Other      bugme-janitors@lists.osdl.org
Floppy works better, but still not right

664  Drivers    Network    jgarzik@pobox.com
bcm4400 won't transmit

669  Drivers    Input De   vojtech@suse.cz
Alt+SysRq+T doesn't work on Compaq Armada 1592DT

674  Drivers    Input De   vojtech@suse.cz
scancode 0x13 rejected

677  Platform   i386       mbligh@aracnet.com
failure to boot 2.5.68 and higher

681  Platform   x86-64     ak@suse.de
32bit programs don't dump the SSE2 registers when coredumping on x86-64

682  Platform   x86-64     ak@suse.de
NMI watchdog appears to run too often on x86-64

683  Platform   x86-64     ak@suse.de
modules, kernel .text cannot be accessed through /proc/kcore

685  Platform   x86-64     ak@suse.de
need to core dump 64bit vsyscall code

686  Platform   x86-64     ak@suse.de
need dwarf2 description of assembly function/irqstacks

694  File Sys   Other      bugme-janitors@lists.osdl.org
autofs_wqt_t changed size halfway a stable kernel series. ABI BREAK!!!

698  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
hang after memory resources listed on fujitsu C-series lifebook

704  Drivers    Input De   vojtech@suse.cz
need hotplug support on /dev/input/mouseN

705  Drivers    Input De   vojtech@suse.cz
using xmodmap to reverse mouse buttons, causes button 3 to behave as 
though 1

706  Drivers    Input De   vojtech@suse.cz
ps/2 keyboard detection in infinite loop

710  Power Ma   ACPI       andrew.grover@intel.com
Kernel freezes with ACPI enabled

717  Drivers    Input De   vojtech@suse.cz
Laptop keyboard doesn't work

723  Networki   Other      acme@conectiva.com.br
The tc tool doesn't work

726  Power Ma   ACPI       andrew.grover@intel.com
Battery info/status query called twice through /proc interface

728  Drivers    Console/   jsimmons@infradead.org
rivafb problem

729  Platform   Alpha      rth@twiddle.net
Alpha kernel sound/core compile fails

731  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
Errors message and paused system with IDE ZIP

733  Drivers    Network    jgarzik@pobox.com
vortex_timer caused "IRQ # nobody cared" msg

740  Other      Other      jgarzik@pobox.com
initramfs fails to unpack certain cpio archives

741  Drivers    Console/   jsimmons@infradead.org
[2.5.69-bk14] Unable to handle kernel null pointer

742  Drivers    Sound      bugme-janitors@lists.osdl.org
Maestro3/Allegro-1 Soundcard has poor sound quality

743  Drivers    Sound      bugme-janitors@lists.osdl.org
Maestro3/Allegro-1 Soundcard has no midi support

758  IO/Stora   Block La   axboe@suse.de
Sometimes when compiling the kernel panics

762  Drivers    Sound      bugme-janitors@lists.osdl.org
cs4232, cs4236 module loading problem

763  Memory M   Other      akpm@digeo.com
machine hang, log file indicates "Slab corruption"

766  Drivers    SCSI       andmike@us.ibm.com
aic7xxx.c fails to compile (errno)

768  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
IDE modules issue when all IDE is module

769  Process    Other      bugme-janitors@lists.osdl.org
Kernel locks up when heavily using pthread keys (NPTL)

773  Platform   i386       mbligh@aracnet.com
strange IO-APIC-edge  in /proc/interrupts

774  Power Ma   ACPI       andrew.grover@intel.com
ACPI interrupt storm when ACPI operates in IO-APIC-level mode

782  Other      Other      bugme-janitors@lists.osdl.org
random repeating of keys

787  Drivers    SCSI       andmike@us.ibm.com
Errors with feral driver

788  File Sys   ext3       akpm@digeo.com
Security!->Chmod changes two files instead of one on ext3fs !

789  File Sys   ext3       akpm@digeo.com
Security!->Chmod changes two files instead of one on ext3fs !

790  Platform   i386       mbligh@aracnet.com
SDET hangs

795  Drivers    Input De   vojtech@suse.cz
hiddev is loosing events (getting 0x0 events instead of the real ones)

797  Drivers    Network    jgarzik@pobox.com
error during shutdown "eth1: error -110 writing Tx descriptor to BAP"

806  Drivers    Sound      bugme-janitors@lists.osdl.org
Full-duplex mode on nForce motherboards

808  Networki   Other      acme@conectiva.com.br
register_cpu_notifier in flow.c causes fatal error during make

811  Drivers    Input De   vojtech@suse.cz
Mouse pointer displacement

814  Platform   i386       mbligh@aracnet.com
nForce2 intergrated GF4 is not detected by vesafb




