Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTJXNOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 09:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJXNOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 09:14:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33961 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262182AbTJXNNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 09:13:49 -0400
Message-ID: <3F99243F.8030001@us.ibm.com>
Date: Fri, 24 Oct 2003 09:08:15 -0400
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

There are 250 bugs sitting in the NEW state for more than 28 days
that don't appear to have any activity.  74 of these bugs are owned
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

143  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated

160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

191  Platform   i386       akpm@digeo.com
Panic on shutdown

207  Drivers    Console/   jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

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
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds. From Andy Chou

239  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

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

301  IO/Stora   Block La   axboe@suse.de
ISA_DMA_THRESHOLD

320  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/ip2/i2lib.c

332  Other      Other      bugme-janitors@lists.osdl.org
/etc/fstab LABEL for root partition not working

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

396  IO/Stora   Other      bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

441  Drivers    Console/   jsimmons@infradead.org
Badness in Riva framebuffer

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1&2/ac test tree

447  Power Ma   ACPI       len.brown@intel.com
Reduce ACPI-related boot messages

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

456  Networki   IPV4       bugme-janitors@lists.osdl.org
Apache test framework causes kernel panic in tcp_v4_get_port

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned

470  Power Ma   ACPI       len.brown@intel.com
Permit drivers to enable their devices for wake (e.g. sleep button)

477  Networki   Other      acme@conectiva.com.br
mii-tool and ethtool require root to query

481  Drivers    USB        greg@kroah.com
Annoying full pathname prefixes before messages during boot.

486  Drivers    Console/   jsimmons@infradead.org
compile failure in drivers/video/pm2fb.c

487  Drivers    Other      bugme-janitors@lists.osdl.org
hisax.ko needs unknown symbol            ^M

489  Power Ma   ACPI       len.brown@intel.com
Boot hang on HP ZE4145

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

529  Power Ma   ACPI       len.brown@intel.com
Yenta + ACPI = lockup

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

599  Power Ma   ACPI       len.brown@intel.com
rtl8139 NIC don't work while CONFIG_ACPI=y

609  Drivers    Input De   vojtech@suse.cz
Compilation error for adbhid.c [ppc]

611  Drivers    Sound      bugme-janitors@lists.osdl.org
keywest driver fails to compile due to i2c interface changes

612  IO/Stora   SCSI       andmike@us.ibm.com
aic7xxx driver hang

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

704  Drivers    Input De   vojtech@suse.cz
need hotplug support on /dev/input/mouseN

705  Drivers    Input De   vojtech@suse.cz
using xmodmap to reverse mouse buttons, causes button 3 to behave as 
though 1

706  Drivers    Input De   vojtech@suse.cz
ps/2 keyboard detection in infinite loop

710  Power Ma   ACPI       len.brown@intel.com
Kernel freezes with ACPI enabled

716  Power Ma   ACPI       len.brown@intel.com
2.4.21-rc1+acpi_24042003: Failure booting on Compaq 1722EA

721  File Sys   NFS        trond.myklebust@fys.uio.no
[perf] [SPECsfs97] SPECsfs97 fails to run on EXT3 fs on 2.5.68

723  Networki   Other      acme@conectiva.com.br
The tc tool doesn't work

728  Drivers    Console/   jsimmons@infradead.org
rivafb problem

729  Platform   Alpha      rth@twiddle.net
Alpha kernel sound/core compile fails

730  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
ide-floppy hangs the machine

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

793  Power Ma   ACPI       len.brown@intel.com
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

816  IO/Stora   SCSI       andmike@us.ibm.com
few warnings during compiling 2.5.72

825  Power Ma   Other      bugme-janitors@lists.osdl.org
reboot notifiers run after power off

829  Drivers    SCSI       andmike@us.ibm.com
Problem with ide-scsi

837  Networki   Other      acme@conectiva.com.br
PPP async spin_lock_bh badness

843  Power Ma   ACPI       len.brown@intel.com
Getting very high CPU load on Laptop with ACPI

845  Power Ma   ACPI       len.brown@intel.com
VIA ACPI/APIC interrupts problems

849  File Sys   ext3       akpm@digeo.com
[perf][tiobench] tiobench sequential write degrades in 2.5.72-bk2

862  Memory M   Slab All   akpm@digeo.com
[x86_64] Reproducible crash in {memset+164}

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

890  Memory M   Other      akpm@digeo.com
performance regression compared to 2.4.20 under tight RAM conditions

891  Power Ma   ACPI       len.brown@intel.com
kernel boot hangs on line "executing _Sta and_INI methods:...." on nb 
presario

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

918  Drivers    Network    jgarzik@pobox.com
Warnings during loading tulip driver module

924  Drivers    Network    bugme-janitors@lists.osdl.org
Can't eject then insert again a prism/orinoco pcmcia card

935  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Intel ICH5 S-ATA problem

941  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Kernel hangs on boot with HP CDWriter 9300i

943  IO/Stora   SCSI       andmike@us.ibm.com
Request for Scsi_Host configurable CMD TimeOut per HBA

945  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
System hang when mount a zip disk.

947  Process    Schedule   rml@tech9.net
Audio skpping

953  Drivers    Input De   vojtech@suse.cz
Touchpad forced as Synaptic but it isn't a Synaptics touchpad

956  IO/Stora   MD         bugme-janitors@lists.osdl.org
Kernel hangs when using a primary and secondary IDE controller under 
software

957  Drivers    ISDN       bugme-janitors@lists.osdl.org
Isdn system not working at all in 2.5/2.6

958  File Sys   Other      bugme-janitors@lists.osdl.org
file name error in vfat

959  Process    Schedule   rml@tech9.net
'make menuconfig' hangs in a gnome-terminal

960  Drivers    Other      mochel@osdl.org
device attach ignores return code - always returns 0

963  File Sys   devfs      bugme-janitors@lists.osdl.org
'rmmod hid' causes 'kernel BUG' in devfs core

974  IO/Stora   SCSI       andmike@us.ibm.com
once scsi cdrom drive in vcd mode, it doesn't get reset in normal data mode

977  Drivers    Console/   jsimmons@infradead.org
radeon framebuffer totally white on any framebuffer operation

978  Networki   IPV4       bugme-janitors@lists.osdl.org
ARPs sent with wrong src IP address

980  Drivers    Network    jgarzik@pobox.com
tulip driver does not establish connection

981  Drivers    Network    jgarzik@pobox.com
tg3 loses interrupt

982  Drivers    Serial     rmk@arm.linux.org.uk
cu -l /dev/ttyS0 got a signal hangup in 2.5 and 2.6.0-test2 kernel

988  Power Ma   ACPI       len.brown@intel.com
Badness in local_bh_enable when entering S3 from e100

990  Drivers    Sound      bugme-janitors@lists.osdl.org
ac97 dumps messages on console (but working)

991  Power Ma   ACPI       len.brown@intel.com
/proc/acpi does not exist, processor and thermal_zone are directly in /proc

995  Drivers    ISDN       bugme-janitors@lists.osdl.org
isdn won't compile with CONFIG_ISDN_DIVERSION=[ym]

996  Networki   Other      acme@conectiva.com.br
Can't create right tunnel

1005  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA  VIA SOUND DRIVER CHIRPS AND IS DISTORTED

1009  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Startup hangs with SiI 3112 driver compiled in for some time

1010  Other      Other      bugme-janitors@lists.osdl.org
lcd video scale reset at boot

1011  Other      Other      bugme-janitors@lists.osdl.org
aironet scheduling while atomic

1012  Power Ma   ACPI       luming.yu@intel.com
2.5.x - acpi doesn't like my power status

1014  File Sys   Other      bugme-janitors@lists.osdl.org
Infrequent but persistent oops in either XFS or block layer

1016  Other      Other      bugme-janitors@lists.osdl.org
Boot blocked on  2.6.0-test2

1017  Memory M   Page All   akpm@digeo.com
Debug: sleeping function called from invalid context at mm/page_alloc.c:545

1018  File Sys   NFS        trond.myklebust@fys.uio.no
root nfs mountpoint via dhcp does not work

1022  Other      Modules    bugme-janitors@lists.osdl.org
Make Install Complains"No module raid0 found for kernel"

1026  Power Ma   ACPI       len.brown@intel.com
ACPI and APIC doesn't work together

1031  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
dvd-player on HPT302 fail with acpi on

1032  IO/Stora   Other      bugme-janitors@lists.osdl.org
Toshiba laptop keyboard hang

1034  Alternat   mm         akpm@digeo.com
Mouse wheel issue

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

1058  IO/Stora   SCSI       andmike@us.ibm.com
Lock-up during CD Audio Extraction via ide-scsi and grip

1059  Power Ma   ACPI       len.brown@intel.com
3c905B Driver Doesn't work in 2.6.0_test2

1060  Drivers    Network    jgarzik@pobox.com
3c905B Causes system to freeze

1064  Networki   Other      acme@conectiva.com.br
Network doesn't work but interface is up

1074  Drivers    Input De   vojtech@suse.cz
Neither Touchpad nor Pointer work on a Laptop with a Touchpat and a Pointer

1075  File Sys   Samba/SM   bugme-janitors@lists.osdl.org
corrupt dirctory when mounting smbfs from a WinXP box with unicode option

1082  Drivers    Network    jgarzik@pobox.com
Intel e100 driver causes dhcp to fail

1091  Memory M   Other      akpm@digeo.com
out of memory lockups

1093  Power Ma   ACPI       len.brown@intel.com
acpi breaking synaptics mouse support on Acer Travelmate 260

1100  Drivers    Console/   jsimmons@infradead.org
black screen

1101  Drivers    Input De   vojtech@suse.cz
Keyboard does not work at all (laptop)

1103  Alternat   mjb        mbligh@aracnet.com
reiserfs compile breaks on 2.6.0-test3-mjb1

1105  Memory M   Slab All   akpm@digeo.com
slab error in check_poison_obj(): cache `task_struct'

1115  Power Ma   ACPI       len.brown@intel.com
IO-APIC errors on VIA-KT400

1118  Drivers    SCSI       andmike@us.ibm.com
atp870u driver causes segfault on load

1119  Drivers    Sound      bugme-janitors@lists.osdl.org
OPL-3 synth doesn't work on SB16 (isapnp problem?)

1121  Drivers    Input De   vojtech@suse.cz
Race condition with keyboard input and loading uhci-hcd

1125  Drivers    Network    jgarzik@pobox.com
Device class '3c59x' does not have a release() function, it is broken 
and must

1127  Power Ma   ACPI       len.brown@intel.com
Asus PR-DLSW: Cannot boot with ACPI enabled

1130  Networki   IPV4       bugme-janitors@lists.osdl.org
GRE tunnels freeze kernel

1134  Power Ma   ACPI       len.brown@intel.com
Kernel halts halfway booting with acpi=force on via/award

1141  Power Ma   ACPI       len.brown@intel.com
acpi_poweroff fails to power down machine

1145  Drivers    Sound      bugme-janitors@lists.osdl.org
alsa emu10k1 high volume feedback

1146  Drivers    Input De   vojtech@suse.cz
Mouse cursor jumps when moved slowly

1148  Networki   IPV4       bugme-janitors@lists.osdl.org
when using ipsec with DSL connections communication will hang if mtu is 
1500(

1149  Drivers    Input De   vojtech@suse.cz
Linker failure when configuring serio as module

1154  Drivers    Input De   vojtech@suse.cz
USB mouse affects keyboard repeat -- strange

1155  Drivers    Network    jgarzik@pobox.com
Keyboard repeats randomly after bringing down eth0

1156  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Loose IRQ or fail SCSI Commands under heavy I/O

1157  Drivers    Network    jgarzik@pobox.com
8139too : Too much work at interrupt

1159  Drivers    Console/   jsimmons@infradead.org
Matrox Framebuffer does not compile

1171  Power Ma   ACPI       len.brown@intel.com
Boot hang - ThinkPad T40

1172  Drivers    Input De   vojtech@suse.cz
Keybord becomes unresponsive from XWindows

1176  Networki   IPV4       bugme-janitors@lists.osdl.org
icmp redirect shuts connexions

1177  Power Ma   ACPI       len.brown@intel.com
print_IO_APIC() is too early in ACPI mode

1179  File Sys   ReiserFS   reiserfs-dev@namesys.com
AMD Viper driver and ReiserFS root partition must use notail in fstab

1181  Drivers    Network    jgarzik@pobox.com
What happened to the Broadcom BCM57* drivers?

1190  Power Ma   Other      bugme-janitors@lists.osdl.org
oops on echo 4 > /proc/acpi/sleep

1191  Drivers    USB        greg@kroah.com
Unloading USB modules when using PL2303 and cu causes an OOPS

1192  Drivers    Network    jgarzik@pobox.com
e1000 driver produces strange statistics

1193  Other      Other      bugme-janitors@lists.osdl.org
Architecture specific flags get passed twice to compiler

1195  Drivers    Sound      bugme-janitors@lists.osdl.org
Sound doesn't play at correct speed

1196  Platform   Alpha      rth@twiddle.net
SMP fails to compile

1197  Platform   Alpha      rth@twiddle.net
initramfs.S error

1198  IO/Stora   Block La   axboe@suse.de
loop deadlock on block-backed writes

1199  Power Ma   ACPI       len.brown@intel.com
Interrupt is lost after resuming from S3 state.

1203  Power Ma   ACPI       len.brown@intel.com
DMA IDE hangs with APIC enabled on nForce2 systems

1205  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Loading the cmd64x driver for a second interface fails

1207  Drivers    Sound      bugme-janitors@lists.osdl.org
pcm_lib.c:214: Unexpected hw_pointer value

1208  Drivers    SCSI       andmike@us.ibm.com
drivers/scsi/aic7xxx does not compile with gcc 3.3

1212  File Sys   ext3       akpm@digeo.com
more than 40,000 files in a directory cause extreme slow down

1214  Networki   Other      acme@conectiva.com.br
Changing link status of the interface up and down gets stuck

1218  Power Ma   ACPI       len.brown@intel.com
i850 chipset: hangs if acpi is enabled

1223  Other      Configur   zippel@linux-m68k.org
Menuconfig freeze

1224  Drivers    Sound      bugme-janitors@lists.osdl.org
ad1816a: my soundcard only works with allowdma0

1225  Networki   Other      acme@conectiva.com.br
hermes pcmcia driver selection in make menuconfig confusing

1233  IO/Stora   IDE        bzolnier@elka.pw.edu.pl
Hang when trying to mount root fs

1236  Drivers    Network    jgarzik@pobox.com
e100 driver hangs when trying to stop the interface

1237  Power Ma   ACPI       len.brown@intel.com
T23 boot hang with intel(R) PRO/100 PCMCIA net card plugged in.

1239  Drivers    Network    jgarzik@pobox.com
miscomputing of checksums if icmp pkg > MTU

1242  File Sys   devfs      bugme-janitors@lists.osdl.org
devfs oops with SMP kernel (not in UP mode)

1243  Networki   IPV4       bugme-janitors@lists.osdl.org
Communication with ipsec api seems to hang after some operation

1244  Platform   i386       mbligh@aracnet.com
/proc/interrupts seems to be unbalanced

1250  Networki   IPV4       bugme-janitors@lists.osdl.org
IPSEC-TUNNEL gives error messages in the system log and tcpdump.

1255  Drivers    Input De   vojtech@suse.cz
PS/2 mouse problem with KVM switch

1259  IO/Stora   Other      zwane@arm.linux.org.uk
Floppy check_disk_change after queue removed

1260  Power Ma   ACPI       len.brown@intel.com
multi-byte access in indexfields broken

1262  Networki   Other      acme@conectiva.com.br
bluez thinkpad t40p kernel BUG on usage of l2cap

1266  Drivers    Network    bugme-janitors@lists.osdl.org
Bluetooth sdptool & rfcomm cause oops

1268  IO/Stora   SCSI       andmike@us.ibm.com
Saw underflow

1271  Networki   IPV4       bugme-janitors@lists.osdl.org
Kernel panic in network code
















