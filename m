Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUANPQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUANPQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:16:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:57598 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266105AbUANPQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:16:18 -0500
Message-ID: <40055CB8.50408@us.ibm.com>
Date: Wed, 14 Jan 2004 10:14:00 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs sitting in the NEW state for more than 60 days
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 252 bugs sitting in the NEW state for more than 60 days
that don't appear to have any activity.
Please check the bugs before working on them to see if they are
still available.

Kernel Bug Tracker: http://bugme.osdl.org



122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

191  Platform   i386       akpm@digeo.com
Panic on shutdown

216  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/pci2220i.c

220  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/AM53C974.c

236  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou <acc@cs.stanford.edu>

237  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

238  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds. From Andy 
Chou <ac

239  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu

243  Drivers    SCSI       chase.maupin@hp.com
possiblecpqfcTSworker.c out of bounds bug from Andy Chou 
<acc@cs.stanford.edu>

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

283  Drivers    Serial     bugme-janitors@lists.osdl.org
Compile failure of drivers/char/isicom.c

294  File Sys   devfs      bugme-janitors@lists.osdl.org
devfs_dealloc_unique_number() when not initialized

297  Platform   i386       mbligh@aracnet.com
Booting kernel 2.5.57 and higher ends with failure

301  IO/Stora   Block La   axboe@suse.de
ISA_DMA_THRESHOLD

320  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/ip2/i2lib.c

361  Drivers    Sound      bugme-janitors@lists.osdl.org
system hangs until keyrpress

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

371  Drivers    Other      bugme-janitors@lists.osdl.org
Badness in kobject_register at lib/kobject.c:152

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

396  IO/Stora   Other      bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of

400  Other      Other      bugme-janitors@lists.osdl.org
Highpoint 370 triggers sleeping from illegal context debug code.

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1&2/ac test tree

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

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

576  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
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

609  Drivers    Input De   vojtech@suse.cz
Compilation error for adbhid.c [ppc]

621  File Sys   devfs      bugme-janitors@lists.osdl.org
oups while running mc, not able to run xterm nor kterm in xfree86

627  IO/Stora   DIO        akpm@digeo.com
[perf][rawiobench] serveraid adapter 2x slower on 2.5

628  Alternat   mjb        bhartner@us.ibm.com
Need configurable TASK_UNMAPPED_BASE per process

643  Drivers    Console/   jsimmons@infradead.org
Problems when using both fbcon and vgacon

648  Other      Other      mochel@osdl.org
sysfs initialisation failure.

650  Drivers    Other      mochel@osdl.org
driver model needs easy way to create subdirs

657  Networki   Other      acme@conectiva.com.br
The HTB utility is not working properly using 2.5.73 kernel

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

706  Drivers    Input De   vojtech@suse.cz
ps/2 keyboard detection in infinite loop

723  Networki   Other      acme@conectiva.com.br
The tc tool doesn't work

729  Platform   Alpha      rth@twiddle.net
Alpha kernel sound/core compile fails

730  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
ide-floppy hangs the machine

731  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Errors message and paused system with IDE ZIP

738  Alternat   mm         akpm@digeo.com
kernel BUG at fs/jbd/transaction.c:2023!

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

773  Platform   i386       mbligh@aracnet.com
strange IO-APIC-edge  in /proc/interrupts

782  Other      Other      bugme-janitors@lists.osdl.org
random repeating of keys

788  File Sys   ext3       akpm@digeo.com
Security!->Chmod changes two files instead of one on ext3fs !

789  File Sys   ext3       akpm@digeo.com
Security!->Chmod changes two files instead of one on ext3fs !

790  Platform   i386       mbligh@aracnet.com
SDET hangs

795  Drivers    Input De   vojtech@suse.cz
hiddev is loosing events (getting 0x0 events instead of the real ones)

800  Process    Schedule   rml@tech9.net
2.5.70-bk15 - flood of "scheduling while atomic!" and panic on boot

806  Drivers    Sound      bugme-janitors@lists.osdl.org
Full-duplex mode on nForce motherboards

808  Networki   Other      acme@conectiva.com.br
register_cpu_notifier in flow.c causes fatal error during make

816  IO/Stora   SCSI       andmike@us.ibm.com
few warnings during compiling 2.5.72

825  Power Ma   Other      bugme-janitors@lists.osdl.org
reboot notifiers run after power off

849  File Sys   ext3       akpm@digeo.com
[perf][tiobench] tiobench sequential write degrades in 2.5.72-bk2

864  Drivers    Input De   vojtech@suse.cz
Touchpad no longer works

869  Alternat   mm         akpm@digeo.com
System hangs in IO schedule

875  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
pm3fb does not compile

876  Drivers    Console/   jsimmons@infradead.org
cirrusfb does not compile

879  Drivers    Console/   jsimmons@infradead.org
radeon fbdev oopses when watching a picture on the console with fbi

880  Drivers    Other      bugme-janitors@lists.osdl.org
ftape driver failed to build

885  Drivers    Console/   jsimmons@infradead.org
neofb has issue with scrollback

886  File Sys   Other      bugme-janitors@lists.osdl.org
On mipsel linker says, .o file build with wrong byte order.

892  Alternat   mm         akpm@digeo.com
kernel BUG at include/linux/list.h:148!

896  Networki   Other      acme@conectiva.com.br
sleeping function called from illegal context at include/linux/rwsem.h:43

901  Memory M   Other      akpm@digeo.com
sleeping function called from illegal context at include/linux/rwsem.h:43

909  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Unresolved symbols in .../video/console/fbcon.ko

912  Drivers    Input De   vojtech@suse.cz
Autorepeat storm on USB keyboard resulting in X/matroxfb intermingling 
on G400

914  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
"bad: scheduling while atomic!" flood after IDE error

916  Drivers    USB        vojtech@suse.cz
Logitech USB mouse invalid configuration

924  Drivers    Network    bugme-janitors@lists.osdl.org
Can't eject then insert again a prism/orinoco pcmcia card

935  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Intel ICH5 S-ATA problem

941  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Kernel hangs on boot with HP CDWriter 9300i

943  IO/Stora   SCSI       andmike@us.ibm.com
Request for Scsi_Host configurable CMD TimeOut per HBA

953  Drivers    Input De   vojtech@suse.cz
Touchpad forced as Synaptic but it isn't a Synaptics touchpad

956  IO/Stora   MD         bugme-janitors@lists.osdl.org
Kernel hangs when using a primary and secondary IDE controller under 
software

957  Drivers    ISDN       bugme-janitors@lists.osdl.org
Isdn system not working at all in 2.5/2.6

958  File Sys   Other      bugme-janitors@lists.osdl.org
file name error in vfat

963  File Sys   devfs      bugme-janitors@lists.osdl.org
'rmmod hid' causes 'kernel BUG' in devfs core

974  IO/Stora   SCSI       andmike@us.ibm.com
once scsi cdrom drive in vcd mode, it doesn't get reset in normal data mode

977  Drivers    Console/   jsimmons@infradead.org
radeon framebuffer totally white on any framebuffer operation

978  Networki   IPV4       bugme-janitors@lists.osdl.org
ARPs sent with wrong src IP address

982  Drivers    Serial     rmk@arm.linux.org.uk
cu -l /dev/ttyS0 got a signal hangup in 2.5 and 2.6.0-test2 kernel

995  Drivers    ISDN       bugme-janitors@lists.osdl.org
isdn won't compile with CONFIG_ISDN_DIVERSION=[ym]

996  Networki   Other      acme@conectiva.com.br
Can't create right tunnel

1010  Other      Other      bugme-janitors@lists.osdl.org
lcd video scale reset at boot

1011  Other      Other      bugme-janitors@lists.osdl.org
aironet scheduling while atomic

1014  File Sys   Other      bugme-janitors@lists.osdl.org
Infrequent but persistent oops in either XFS or block layer

1015  Platform   i386       mbligh@aracnet.com
260t1-7 && 24x --- crash / lock-up (when agpgart, ATI chipset == true; 
and sin

1017  Memory M   Page All   akpm@digeo.com
Debug: sleeping function called from invalid context at mm/page_alloc.c:545

1018  File Sys   NFS        trond.myklebust@fys.uio.no
root nfs mountpoint via dhcp does not work

1022  Other      Modules    bugme-janitors@lists.osdl.org
Make Install Complains"No module raid0 found for kernel"

1025  Drivers    Input De   vojtech@suse.cz
Keyboard repeat rate is broken

1028  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
kernel hang when mount music cd

1030  Networki   Other      acme@conectiva.com.br
racoon causes oops when implementing IPSec key

1031  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
dvd-player on HPT302 fail with acpi on

1032  IO/Stora   Other      bugme-janitors@lists.osdl.org
Toshiba laptop keyboard hang

1040  Networki   Other      acme@conectiva.com.br
kernel panic while trying to bring bridge up

1044  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
STT20000A Tape drive dma blacklist

1046  File Sys   devfs      bugme-janitors@lists.osdl.org
first user login gives bug in devfs

1048  Other      Modules    bugme-janitors@lists.osdl.org
hiddev_events missing when reading from /dev/hiddev0

1052  Drivers    Other      bugme-janitors@lists.osdl.org
ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:482

1054  Networki   Netfilte   laforge@gnumonks.org
loading iptables modules kill raid5 kernel thread

1067  Drivers    USB        rddunlap@osdl.org
USB printer is not seen anymore

1072  Drivers    Input De   vojtech@suse.cz
Laptop touchpad does not work; synaptics driver missing

1074  Drivers    Input De   vojtech@suse.cz
Neither Touchpad nor Pointer work on a Laptop with a Touchpat and a Pointer

1075  File Sys   Samba/SM   bugme-janitors@lists.osdl.org
corrupt dirctory when mounting smbfs from a WinXP box with unicode option

1091  Memory M   Other      akpm@digeo.com
out of memory lockups

1097  File Sys   NFS        trond.myklebust@fys.uio.no
NFS causing kernel BUG at lines 1701 and 1702 in slab.c

1100  Drivers    Console/   jsimmons@infradead.org
black screen

1101  Drivers    Input De   vojtech@suse.cz
Keyboard does not work at all (laptop)

1111  Drivers    Other      bugme-janitors@lists.osdl.org
serial167.c - Complie error:  BH functions removed from 
include/linux/interrup

1118  Drivers    SCSI       andmike@us.ibm.com
atp870u driver causes segfault on load

1119  Drivers    Sound      bugme-janitors@lists.osdl.org
OPL-3 synth doesn't work on SB16 (isapnp problem?)

1121  Drivers    Input De   vojtech@suse.cz
Race condition with keyboard input and loading uhci-hcd

1122  Drivers    SCSI       andmike@us.ibm.com
Kernel oops

1145  Drivers    Sound      bugme-janitors@lists.osdl.org
alsa emu10k1 high volume feedback

1148  Networki   IPV4       bugme-janitors@lists.osdl.org
when using ipsec with DSL connections communication will hang if mtu is 
1500(t

1149  Drivers    Input De   vojtech@suse.cz
Linker failure when configuring serio as module

1154  Drivers    Input De   vojtech@suse.cz
USB mouse affects keyboard repeat -- strange

1156  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Loose IRQ or fail SCSI Commands under heavy I/O

1163  Drivers    SCSI       andmike@us.ibm.com
removing usb-storage driver cause some processes to go into 
uninterruptible sl

1172  Drivers    Input De   vojtech@suse.cz
Keybord becomes unresponsive from XWindows

1179  File Sys   ReiserFS   reiserfs-dev@namesys.com
AMD Viper driver and ReiserFS root partition must use notail in fstab

1189  Drivers    USB        dbrownell@users.sourceforge.net
usb mouse hangs

1190  Power Ma   Other      bugme-janitors@lists.osdl.org
oops on echo 4 > /proc/acpi/sleep

1191  Drivers    USB        greg@kroah.com
Unloading USB modules when using PL2303 and cu causes an OOPS

1193  Other      Other      bugme-janitors@lists.osdl.org
Architecture specific flags get passed twice to compiler

1194  Drivers    USB        rddunlap@osdl.org
Cannot print to my USB Printer: Epson Stylus Color 680 (usblp)

1196  Platform   Alpha      rth@twiddle.net
SMP fails to compile

1197  Platform   Alpha      rth@twiddle.net
initramfs.S error

1198  IO/Stora   Block La   axboe@suse.de
loop deadlock on block-backed writes

1205  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Loading the cmd64x driver for a second interface fails

1212  File Sys   ext3       akpm@digeo.com
more than 40,000 files in a directory cause extreme slow down

1214  Networki   Other      acme@conectiva.com.br
Changing link status of the interface up and down gets stuck

1225  Networki   Other      acme@conectiva.com.br
hermes pcmcia driver selection in make menuconfig confusing

1231  File Sys   Other      bugme-janitors@lists.osdl.org
Warning: "set_special_pids" [fs/jffs/jffs.ko] undefined!

1232  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Wont build without DMA support enabled

1233  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Hang when trying to mount root fs

1240  Drivers    USB        akpm@digeo.com
USB HCD reports an unhandled IRQ and throws a call trace

1243  Networki   IPV4       bugme-janitors@lists.osdl.org
Communication with ipsec api seems to hang after some operation

1244  Platform   i386       mbligh@aracnet.com
/proc/interrupts seems to be unbalanced

1250  Networki   IPV4       bugme-janitors@lists.osdl.org
IPSEC-TUNNEL gives error messages in the system log and tcpdump.

1254  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
cdrom reading and writing broken in >=2.6-test3 (random errors, worked 
on 2.5.

1256  Networki   Other      acme@conectiva.com.br
drivers/net/wan/cosa.c won't compile

1262  Networki   Other      acme@conectiva.com.br
bluez thinkpad t40p kernel BUG on usage of l2cap

1264  IO/Stora   SCSI       andmike@us.ibm.com
qla1280 driver causes bad: scheduling while atomic error on boot

1266  Drivers    Network    bugme-janitors@lists.osdl.org
Bluetooth sdptool & rfcomm cause oops

1275  Drivers    USB        greg@kroah.com
Some USB bug (sorry it isn't clear but i didn't find it i only send it 
to you)

1282  Platform   i386       mbligh@aracnet.com
Hard Lockup

1284  Platform   i386       mbligh@aracnet.com
Asus P5AB broken BIOS reading ESCD

1289  File Sys   Other      bugme-janitors@lists.osdl.org
Intermezzo fs won't compile

1290  File Sys   ReiserFS   reiserfs-dev@namesys.com
Segmentation Fault and console bug message from trying to 'mv' a file.

1292  Drivers    Sound      bugme-janitors@lists.osdl.org
emu10k alsa driver fails to work witout OSS api support

1296  Drivers    Input De   vojtech@suse.cz
setkeycodes not working

1301  Drivers    Input De   vojtech@suse.cz
Synaptic touchpad doesn't work properly

1308  Platform   i386       mbligh@aracnet.com
MSI-6210 locks up during init

1314  Networki   Other      acme@conectiva.com.br
packet capturing using PACKET_RX_RING does not work as expected

1327  Memory M   Page All   akpm@digeo.com
oops triggered by memory allocation of procmail

1328  Platform   i386       mbligh@aracnet.com
Include files improperly gaurded in #ifdef

1330  Drivers    Sound      bugme-janitors@lists.osdl.org
No sound from via82xx driver in mmap mode.

1332  Drivers    Input De   vojtech@suse.cz
sidewinder driver broken for gameports

1339  Memory M   Page All   akpm@digeo.com
sleeping function called from invalid context

1342  Networki   Other      acme@conectiva.com.br
Samba breaks in test7 kernel

1343  Drivers    Input De   vojtech@suse.cz
Problems with input devices driver PS/2 Touchpad on 2.6.0-test7 kernel

1345  Drivers    Video(AG   davej@codemonkey.org.uk
agpgart: agp_backend_initialize() failed with error -22

1354  Drivers    Sound      bugme-janitors@lists.osdl.org
Multisound Pinnacle / Fiji drivers disappeared

1358  Drivers    Console/   bugme-janitors@lists.osdl.org
Bogus IRQ error message in log

1360  File Sys   Other      bugme-janitors@lists.osdl.org
Can't access /proc/self/fd/0 from sshd when no pty allocated.

1361  Memory M   Slab All   akpm@digeo.com
System halts

1371  Networki   IPV6       bugme-janitors@lists.osdl.org
kernel fails to compile with ipv6 error

1372  Drivers    USB        len.brown@intel.com
sleep/wakeup fails with ehci and ALSA i810 on Dell Inspiron 600m

1375  IO/Stora   Other      bugme-janitors@lists.osdl.org
floppy driver hangs machine on IO error

1384  Platform   PPC-32     bugme-janitors@lists.osdl.org
IBook 2 freezes on sleep.

1389  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
HighPoint 302 has ATA133 support disabled in the driver

1400  Drivers    Input De   vojtech@suse.cz
Touchpad on a HP NX7000 not working right

1402  File Sys   VFS        bugme-janitors@lists.osdl.org
filesystem cache invalidations take too long at NFS mount time

1403  Memory M   Other      akpm@digeo.com
2.6.0-test8 oops: Unable to handle kernel paging request - free_pages_bulk

1407  Memory M   Slab All   akpm@digeo.com
sleeping function called from invalid context at mm/slab.c:1857

1410  File Sys   ext3       akpm@digeo.com
switch off of quota hangs when working with user: UID > 65536

1416  Platform   i386       mbligh@aracnet.com
e820 BIOS "reserved" regions block drivers from registering resources

1420  Drivers    Input De   vojtech@suse.cz
Synaptics Touchpad and Logitech PS2++ mouse don't work together, losing 
sync,

1421  Drivers    Sound      bugme-janitors@lists.osdl.org
CMEDIA CMI8738 AUDIO DRIVER CAUSES HARDLOCKS ON ALL KERNEL 2.6x

1426  Platform   PPC-32     bugme-janitors@lists.osdl.org
slab error in cache_free_debugcheck() ... memory outside object was 
overwritte

1430  File Sys   SysFS      mochel@osdl.org
SysFS oops when rmmod'ing uhci-hcd after resuming from suspend

1439  Platform   i386       mbligh@aracnet.com
Dell Inspiron 8100 with buggy DSDT in ACPI

1451  Drivers    Input De   vojtech@suse.cz
Touchpad scroll wheel problems on Compaq X1005EA 2.6.0-test9 kernel

1452  Other      Modules    bugme-janitors@lists.osdl.org
"Invalid module format" when kernel recompiled without reinstalling modules

1453  Drivers    Sound      bugme-janitors@lists.osdl.org
snd-intel8x0 driver audio problem

1455  Drivers    Sound      bugme-janitors@lists.osdl.org
snd-intel8x0 main speaker silence

1461  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
CPIA Based USB Ezonics Webcam won't work...

1464  Drivers    Sound      bugme-janitors@lists.osdl.org
via82xx.c: invalid via82xx_cur_ptr, using last valid pointer, and lags a 
few s

1466  Drivers    IEEE1394   bcollins@debian.org
firewire device not found

1470  Drivers    Console/   jsimmons@infradead.org
Setting font does affect only current vc

1471  Networki   IPV4       bugme-janitors@lists.osdl.org
deprecated skb_linearize warnings

1481  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
hangs when (un)mounting a IDE drive which has been suspended few seconds ago

1485  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
HPT37X code not updated - new opensource driver available

1486  Networki   Other      acme@conectiva.com.br
bonding: ifenslave won't set mac address

1490  Networki   Other      acme@conectiva.com.br
_decode_session[46] does not set type or code for ICMP or ICMPv6

1491  Networki   Other      acme@conectiva.com.br
No SADB_EXPIRE message sent when soft byte lifetime is reached

1492 Drivers Console/ jsimmons@infradead.org
atyfb: garbled text when overdrawing

1494 Platform PPC-32 bugme-janitors@lists.osdl.org
machine locks up while accessing NIC

1495 Drivers Sound bugme-janitors@lists.osdl.org
ESS Maestro-3i: No sound after suspend wakeup.

1497 Memory M Slab All akpm@digeo.com
LTC5040 - Prolonged NFSv3 activity over TCP causes client to crash.

1498 Drivers SCSI andmike@us.ibm.com
Hangug during burning Audio CDs

1503 Memory M Page All akpm@digeo.com
kernel BUG at include/linux/mm.h:267!

1504 Networki IPV4 bugme-janitors@lists.osdl.org
Kernel panic in ipsec environment

1507 Drivers Sound bugme-janitors@lists.osdl.org
Kernel Oops: Alsa on 2.6.0-test9 (intel8x0)

1509 Alternat mm akpm@digeo.com
Error removing USB Flash hard drive

1511 Drivers Console/ jsimmons@infradead.org
vesa fb conflicts with vga 16

1514 Drivers Console/ jsimmons@infradead.org
Framebuffer driver doesn't load on systems with > 1G memor (radeon, nvidia)

1522 Drivers Input De vojtech@suse.cz
psmouse problem on asrock / sis chip

1528 Alternat mm akpm@digeo.com
Error removing USB Flash hard drive

1539 File Sys NFS trond.myklebust@fys.uio.no
[perf][iozone] NFSv3 reads in 2.6 degrades under memory constraint 
environment


















