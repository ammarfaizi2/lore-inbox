Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbTFMSJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265472AbTFMSJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:09:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9170 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265469AbTFMSI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:08:56 -0400
Message-ID: <3EEA15EC.7080203@us.ibm.com>
Date: Fri, 13 Jun 2003 14:20:28 -0400
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Bugs sitting in the NEW state for more than 28 days
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 125 bugs sitting in the NEW state for more than 28 days
that don't appear to have any activity.  43 of these bugs are owned
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

135  Drivers    Sound      bugme-janitors@lists.osdl.org
SB16/Alsa doesn't work

142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

143  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated wi

154  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/esp.c

155  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/specialix.c

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

191  Platform   i386       akpm@digeo.com
Panic on shutdown

199  Drivers    Flash/Me   dwmw2@infradead.org
compile failure on drivers/mtd/devices/blkmtd.c

205  Drivers    Console/   jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

213  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/ini9100u.c

216  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/pci2220i.c

217  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/dpt_i2o.c

220  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/AM53C974.c

223  Drivers    USB        greg@kroah.com
"usbdevfs is depreciated" message always printed even when usbdevfs is 
not mount

228  Other      Other      bugme-janitors@lists.osdl.org
Make pdfdocs/psdocs/htmldoc fail in 2.5.54

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

240  Drivers    Parallel   bugme-janitors@lists.osdl.org
possible parport/probe.c off by one error from Andy Chou 
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

249  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
uninitialized pointer in sstfb.c from Stanford Checker

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

283  Drivers    Serial     bugme-janitors@lists.osdl.org
Compile failure of drivers/char/isicom.c

294  File Sys   devfs      bugme-janitors@lists.osdl.org
devfs_dealloc_unique_number() when not initialized

295  IO/Stora   Block La   axboe@suse.de
RD device shares elevator queue objects

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

403  Drivers    USB        greg@kroah.com
USB controller locks up on boot.

411  Platform   i386       bugme-janitors@lists.osdl.org
unexpected IO-APIC on GA-7VAX

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1&2/ac test tree

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

452  File Sys   XFS        hch@sgi.com
Null pointer dereference in iget_locked

456  Networki   IPV4       davem@vger.kernel.org
Apache test framework causes kernel panic in tcp_v4_get_port

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned po

469  Networki   Other      acme@conectiva.com.br
/proc/net/dev byte counter wraps after 2^32

477  Networki   Other      acme@conectiva.com.br
mii-tool and ethtool require root to query

481  Drivers    USB        greg@kroah.com
Annoying full pathname prefixes before messages during boot.

485  Other      Other      bugme-janitors@lists.osdl.org
"make rpm" fails; no kernel-2.5.65/debugfiles.list

486  Drivers    Console/   jsimmons@infradead.org
compile failure in drivers/video/pm2fb.c

487  Drivers    Other      bugme-janitors@lists.osdl.org
hisax.ko needs unknown symbol            ^M

488  Drivers    USB        greg@kroah.com
host controller halted after unplugging usb mouse

513  Drivers    USB        vojtech@suse.cz
Wacom driver doesn't work...

521  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
cdrecord fails to see drive caps consistently when using ide-cd

528  Networki   IPV4       davem@vger.kernel.org
In /proc/net/route the default gateway isn't appear

537  Drivers    Sound      bugme-janitors@lists.osdl.org
Alsa EMU10K1 Audigy

539  Drivers    Input De   vojtech@suse.cz
mouse hyper sensitive, and (almost) no 3-button emulation

544  Process    Other      bugme-janitors@lists.osdl.org
bad: scheduling while atomic! warning on modprobe airo_cs

547  Platform   i386       gerrit@us.ibm.com
Hard hang encountered when DOTS was run against PostgreSQL (7.3.2-1) 
Linux kerne

556  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
dma not enabled for IDE hard drives

560  Drivers    Input De   vojtech@suse.cz
Wacom driver isn't working

564  Memory M   MTTR       akpm@digeo.com
kernel prints "mtrr: MTRR 2 not used" twice when exiting X

572  Power Ma   APM        apmbugs@rothwell.emu.id.au
Change compile-time option CONFIG_APM_RTS_IS_GMT to sysctl-tunable kernel

576  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
IDE module loop

579  Drivers    ISDN       bugme-janitors@lists.osdl.org
isdn.ko needs unknown symbol group_send_sig_info

580  Memory M   Other      akpm@digeo.com
freeze after ~12 hours of operation, kswapd OOPS in logs

581  Drivers    SCSI       andmike@us.ibm.com
kernel panic in aha152x

582  Power Ma   APM        apmbugs@rothwell.emu.id.au
network device does not survive laptop suspend

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

615  Drivers    PNP        ambx1@neo.rr.com
"irq 5: nobody cared!" plus calltrace during boot

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

634  Drivers    Network    jgarzik@pobox.com
xirc2ps_cs hangs on shutdown

643  Drivers    Console/   jsimmons@infradead.org
Problems when using both fbcon and vgacon

648  Other      Other      mochel@osdl.org
sysfs initialisation failure.

650  Drivers    Other      mochel@osdl.org
driver model needs easy way to create subdirs

652  File Sys   Other      bugme-janitors@lists.osdl.org
procfs: duplicated capacity entries in /proc/ide/hd*/

653  Platform   i386       mbligh@aracnet.com
i386 NUMA does not work on non x440/Summit

654  IO/Stora   Other      bugme-janitors@lists.osdl.org
Floppy works better, but still not right

655  Networki   IPV6       davem@vger.kernel.org
Infrequent lockups on inbound connections

657  Networki   Other      acme@conectiva.com.br
The HTB utility is not working properly using 2.5.68 kernel

662  Drivers    Sound      bugme-janitors@lists.osdl.org
Badness in kobject_register at lib/kobject.c:288

666  Platform   i386       mbligh@aracnet.com
machine check handler can deadlock

669  Drivers    Input De   vojtech@suse.cz
Alt+SysRq+T doesn't work on Compaq Armada 1592DT

674  Drivers    Input De   vojtech@suse.cz
scancode 0x13 rejected

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

700  Drivers    USB        mdharm-usb@one-eyed-alien.net
Usb may fail just after plugging the device (usb mp3 player)

701  Memory M   Slab All   akpm@digeo.com
slab corruption when mounting ext3

703  Platform   i386       mbligh@aracnet.com
Security vulnerability in "ioperm" system call

704  Drivers    Input De   vojtech@suse.cz
need hotplug support on /dev/input/mouseN

705  Drivers    Input De   vojtech@suse.cz
using xmodmap to reverse mouse buttons, causes button 3 to behave as 
though 1 &

706  Drivers    Input De   vojtech@suse.cz
ps/2 keyboard detection in infinite loop

708  Drivers    Input De   vojtech@suse.cz
loading emu10k1-gp segfaults

710  Power Ma   ACPI       andrew.grover@intel.com
Kernel freezes with ACPI enabled

711  Networki   IPV6       mbligh@aracnet.com
Kernel Bug mentionned in dmesg

714  Drivers    USB        vojtech@suse.cz
HID driver causes slab corruption

721  File Sys   NFS        trond.myklebust@fys.uio.no
[perf] [SPECsfs97] SPECsfs97 fails to run on EXT3 fs on 2.5.68

723  Networki   Other      acme@conectiva.com.br
The tc tool doesn't work




