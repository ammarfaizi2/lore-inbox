Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272503AbTHSQup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272623AbTHSQtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:49:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S276331AbTHSQ1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:27:46 -0400
Message-ID: <3F422691.3070208@us.ibm.com>
Date: Tue, 19 Aug 2003 09:30:57 -0400
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

There are 160 bugs sitting in the NEW state for more than 28 days
that don't appear to have any activity. 52 of these bugs are owned
by bugme-janitors which are good candidates for anyone to work on.
Please check the bugs before working on them to see if they are
still available.

Kernel Bug Tracker: http://bugme.osdl.org

  43  Drivers    Network    jgarzik@pobox.com
e100 drivers crashes on non cache-coherent platforms

  49  Drivers    Console/   jsimmons@infradead.org
register_console() called in illegal context

  72  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

143  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated

155  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/specialix.c

160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

191  Platform   i386       akpm@digeo.com
Panic on shutdown

215  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/pci2000.c

216  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/pci2220i.c

236  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou <acc@cs.stanford.edu>

237  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

238  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds. From Andy Chou

239  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

243  Drivers    SCSI       chase.maupin@hp.com
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

294  File Sys   devfs      bugme-janitors@lists.osdl.org
devfs_dealloc_unique_number() when not initialized

297  Platform   i386       mbligh@aracnet.com
Booting kernel 2.5.57 and higher ends with failure

301  IO/Stora   Block La   axboe@suse.de
ISA_DMA_THRESHOLD

320  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/ip2/i2lib.c

332  Other      Other      bugme-janitors@lists.osdl.org
/etc/fstab LABEL for root partition not working

346  Drivers    SCSI       chase.maupin@hp.com
compile failure in drivers/scsi/cpqfcTSinit.c

361  Drivers    Sound      bugme-janitors@lists.osdl.org
system hangs until keyrpress

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

396  IO/Stora   Other      bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of

400  Other      Other      bugme-janitors@lists.osdl.org
Highpoint 370 triggers sleeping from illegal context debug code.

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

441  Drivers    Console/   jsimmons@infradead.org
Badness in Riva framebuffer

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1&2/ac test tree

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

452  File Sys   XFS        hch@sgi.com
Null pointer dereference in iget_locked

456  Networki   IPV4       bugme-janitors@lists.osdl.org
Apache test framework causes kernel panic in tcp_v4_get_port

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned

477  Networki   Other      acme@conectiva.com.br
mii-tool and ethtool require root to query

481  Drivers    USB        greg@kroah.com
Annoying full pathname prefixes before messages during boot.

487  Drivers    Other      bugme-janitors@lists.osdl.org
hisax.ko needs unknown symbol            ^M

490  Drivers    Input De   vojtech@suse.cz
psmouse.c fails detecting Microsoft PS/2 wheel mice

496  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
No ataraid support in 2.5.65?

504  Drivers    Console/   jsimmons@infradead.org
Framebuffer Console corrupted

513  Drivers    USB        vojtech@suse.cz
Wacom driver doesn't work...

521  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
cdrecord fails to see drive caps consistently when using ide-cd

537  Drivers    Sound      bugme-janitors@lists.osdl.org
Alsa EMU10K1 Audigy

544  Process    Other      bugme-janitors@lists.osdl.org
bad: scheduling while atomic! warning on modprobe airo_cs

556  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
dma not enabled for IDE hard drives

560  Drivers    Input De   vojtech@suse.cz
Wacom driver isn't working

568  Drivers    ISDN       bugme-janitors@lists.osdl.org
compile failure in drivers/isdn/hisax/diva.c

569  Drivers    ISDN       bugme-janitors@lists.osdl.org
compile failure in drivers/isdn/hisax/sedlbauer.c

576  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
IDE module loop

579  Drivers    ISDN       bugme-janitors@lists.osdl.org
isdn.ko needs unknown symbol group_send_sig_info

580  Memory M   Other      akpm@digeo.com
freeze after ~12 hours of operation, kswapd OOPS in logs

588  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
2.5.67 won't get the real partition table for hdb

595  Alternat   ac         alan@lxorguk.ukuu.org.uk
ide-cd stops recognizing cd-rw, starting with 2.5.67-ac1.

609  Drivers    Input De   vojtech@suse.cz
Compilation error for adbhid.c [ppc]

611  Drivers    Sound      bugme-janitors@lists.osdl.org
keywest driver fails to compile due to i2c interface changes

612  IO/Stora   SCSI       andmike@us.ibm.com
aic7xxx driver hang

616  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
PCMCIA cards in cardbus sockets no longer suspended

627  IO/Stora   DIO        akpm@digeo.com
[perf][rawiobench] serveraid adapter 2x slower on 2.5

628  Alternat   mjb        bhartner@us.ibm.com
Need configurable TASK_UNMAPPED_BASE per process

629  Alternat   mjb        bhartner@us.ibm.com
Configuring PAGE_OFFSET

643  Drivers    Console/   jsimmons@infradead.org
Problems when using both fbcon and vgacon

650  Drivers    Other      mochel@osdl.org
driver model needs easy way to create subdirs

655  Networki   IPV6       bugme-janitors@lists.osdl.org
Infrequent lockups on inbound connections

657  Networki   Other      acme@conectiva.com.br
The HTB utility is not working properly using 2.5.73 kernel

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
though 1 &

706  Drivers    Input De   vojtech@suse.cz
ps/2 keyboard detection in infinite loop

717  Drivers    Input De   vojtech@suse.cz
Laptop keyboard doesn't work

721  File Sys   NFS        trond.myklebust@fys.uio.no
[perf] [SPECsfs97] SPECsfs97 fails to run on EXT3 fs on 2.5.68

728  Drivers    Console/   jsimmons@infradead.org
rivafb problem

729  Platform   Alpha      rth@twiddle.net
Alpha kernel sound/core compile fails

731  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Errors message and paused system with IDE ZIP

733  Drivers    Network    jgarzik@pobox.com
vortex_timer caused "IRQ # nobody cared" msg

738  Alternat   mm         akpm@digeo.com
kernel BUG at fs/jbd/transaction.c:2023!

739  Alternat   mm         akpm@digeo.com
Null pointer dereference in ext3_test_allocatable

740  Other      Other      jgarzik@pobox.com
initramfs fails to unpack certain cpio archives

741  Drivers    Console/   jsimmons@infradead.org
[2.5.69-bk14] Unable to handle kernel null pointer

742  Drivers    Sound      bugme-janitors@lists.osdl.org
Maestro3/Allegro-1 Soundcard has poor sound quality

743  Drivers    Sound      bugme-janitors@lists.osdl.org
Maestro3/Allegro-1 Soundcard has no midi support

745  Drivers    Sound      bugme-janitors@lists.osdl.org
Maestro3/Allegro-1 Soundcard has no s/pdif support

746  Networki   IPV6       bugme-janitors@lists.osdl.org
IPv6 route disappears, unable to re-add routing entries

762  Drivers    Sound      bugme-janitors@lists.osdl.org
cs4232, cs4236 module loading problem

763  Memory M   Other      akpm@digeo.com
machine hang, log file indicates "Slab corruption"

768  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
IDE modules issue when all IDE is module

769  Process    Other      bugme-janitors@lists.osdl.org
Kernel locks up when heavily using pthread keys (NPTL)

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

793  Alternat   mm         andrew.grover@intel.com
Thinkpad T30, new BIOS, and ACPI

795  Drivers    Input De   vojtech@suse.cz
hiddev is loosing events (getting 0x0 events instead of the real ones)

797  Drivers    Network    jgarzik@pobox.com
error during shutdown "eth1: error -110 writing Tx descriptor to BAP"

800  Process    Schedule   rml@tech9.net
2.5.70-bk15 - flood of "scheduling while atomic!" and panic on boot

804  Drivers    Input De   vojtech@suse.cz
mouse cursor jumps

806  Drivers    Sound      bugme-janitors@lists.osdl.org
Full-duplex mode on nForce motherboards

808  Networki   Other      acme@conectiva.com.br
register_cpu_notifier in flow.c causes fatal error during make

811  Drivers    Input De   vojtech@suse.cz
Mouse pointer displacement

814  Platform   i386       mbligh@aracnet.com
nForce2 intergrated GF4 is not detected by vesafb

816  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
few warnings during compiling 2.5.72

821  Drivers    SCSI       andmike@us.ibm.com
drivers/scsi/g_NCR5380{,mmio}.o:  multiple definition of 
`generic_NCR5380_proc

825  Power Ma   Other      bugme-janitors@lists.osdl.org
reboot notifiers run after power off

826  Drivers    Network    jgarzik@pobox.com
ibmtr_cs does not compile

829  Drivers    SCSI       andmike@us.ibm.com
Problem with ide-scsi

835  File Sys   XFS        hch@sgi.com
defragmentation (apparently xfs_swapext()) fills files with 0s

840  File Sys   XFS        hch@sgi.com
mounting xfs partition causes Call Trace

849  File Sys   ext3       akpm@digeo.com
[perf][tiobench] tiobench sequential write degrades in 2.5.72-bk2

856  Alternat   mm         akpm@digeo.com
File Sysyem based AIO hangs on 2.5.73-mm1

859  Other      Other      bugme-janitors@lists.osdl.org
make rpm overwrite previously written .config file

861  File Sys   XFS        hch@sgi.com
XFS won't mount on a >2T LVM/DM volume

862  Memory M   Slab All   akpm@digeo.com
[x86_64] Reproducible crash in {memset+164}

869  Alternat   mm         akpm@digeo.com
System hangs in IO schedule

870  File Sys   XFS        hch@sgi.com
kernel BUG at fs/xfs/support/debug.c:106!

871  File Sys   NFS        sampo@symlabs.com
locking over NFS to CFS causes oops in other processes

875  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
pm3fb does not compile

876  Drivers    Console/   jsimmons@infradead.org
cirrusfb does not compile

879  Drivers    Console/   jsimmons@infradead.org
radeon fbdev oopses when watching a picture on the console with fbi

880  Drivers    Other      bugme-janitors@lists.osdl.org
ftape driver failed to build

882  Power Ma   APM        apmbugs@rothwell.emu.id.au
R31 loops under suspend mode (hard disk password mode)

885  Drivers    Console/   jsimmons@infradead.org
neofb has issue with scrollback

886  File Sys   Other      bugme-janitors@lists.osdl.org
On mipsel linker says, .o file build with wrong byte order.

892  Alternat   mm         akpm@digeo.com
kernel BUG at include/linux/list.h:148!

899  Drivers    Other      bugme-janitors@lists.osdl.org
Module make problem

901  Memory M   Other      akpm@digeo.com
sleeping function called from illegal context at include/linux/rwsem.h:43

906  Drivers    Network    jgarzik@pobox.com
Unresolved symbols in orinoco.ko and orinoco_cs.ko

909  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Unresolved symbols in .../video/console/fbcon.ko

913  Drivers    USB        mdharm-usb@one-eyed-alien.net
Segmentation fault when unmounting a smartmedia reader

914  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
"bad: scheduling while atomic!" flood after IDE error

916  Drivers    USB        vojtech@suse.cz
Logitech USB mouse invalid configuration

918  Drivers    Network    jgarzik@pobox.com
Warnings during loading tulip driver module

931  File Sys   Other      bugme-janitors@lists.osdl.org
acorn.c compile error #ifdef CONFIG_ACORN_PARTITION_EESOX

932  Drivers    Sound      bugme-janitors@lists.osdl.org
[OSS] loading cs4232 yields "kobject_register failed"

935  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Intel ICH5 S-ATA problem

941  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Kernel hangs on boot with HP CDWriter 9300i

943  IO/Stora   SCSI       andmike@us.ibm.com
Request for Scsi_Host configurable CMD TimeOut per HBA

945  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
System hang when mount a zip disk.

950  Other      Other      bugme-janitors@lists.osdl.org
The booting screen

957  Drivers    ISDN       bugme-janitors@lists.osdl.org
Isdn system not working at all in 2.5/2.6

958  File Sys   Other      bugme-janitors@lists.osdl.org
file name error in vfat

962  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
PCMCIA Hardware Lockups on ThinkPad

966  Platform   PPC-32     bugme-janitors@lists.osdl.org
kernel/profile.c fails to compile

967  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Onstream DI-30 fails to respond

974  IO/Stora   SCSI       andmike@us.ibm.com
once scsi cdrom drive in vcd mode, it doesn't get reset in normal data mode





