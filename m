Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTEMNyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTEMNyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:54:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55180 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261239AbTEMNyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:54:07 -0400
Message-ID: <3EC0FBB9.30103@us.ibm.com>
Date: Tue, 13 May 2003 10:05:45 -0400
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Bugs sitting in the NEW state for more than 3 weeks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 120 bugs sitting in the NEW state for more than three weeks
that don't appear to have any activity. 52 of these bugs are owned
by bugme-janitors which are good candidates for anyone to work on.
Please check the bugs before working on them to see if they are
still available.

Kernel Bug Tracker: http://bugme.osdl.org

  43  Drivers    Network    scott.feldman@intel.com
e100 drivers crashes on non cache-coherent platforms

  49  Drivers    Console/   jsimmons@infradead.org
register_console() called in illegal context

  72  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

138  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Build error: drivers/video/sis/sis_main.h:299: parse error before "sisfbinfo

142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

143  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated wi

153  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/riscom8.c

154  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/esp.c

155  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/specialix.c

160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

166  Drivers    Network    scott.feldman@intel.com
e100 spits out strange message during startup.

183  IO/Stora   SCSI       andmike@us.ibm.com
megaraid driver panics with IBM EXP300 enclosure

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

192  IO/Stora   Block La   axboe@suse.de
loop.c IV calculation is broken since 2.4.x

193  Other      Other      bugme-janitors@lists.osdl.org
sysrq umount bad ordering (real before loop)

199  Drivers    Flash/Me   dwmw2@infradead.org
compile failure on drivers/mtd/devices/blkmtd.c

201  Drivers    SCSI       andmike@us.ibm.com
compile failure on drivers/net/fc/iph5526.c

205  Drivers    Console/   jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

207  Drivers    Console/   jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

215  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/pci2000.c

216  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/pci2220i.c

217  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/dpt_i2o.c

219  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/tmscsim.c

220  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/AM53C974.c

228  Other      Other      bugme-janitors@lists.osdl.org
Make pdfdocs/psdocs/htmldoc fail in 2.5.54

233  Drivers    Other      bugme-janitors@lists.osdl.org
cdrom/cdu31a.c Out of bounds according to Andy Chou

235  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
ide/ide-lib.c array out of bound according to Andy Chou

236  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou

237  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou

238  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds. From Andy Chou

239  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou

240  Drivers    Parallel   bugme-janitors@lists.osdl.org
possible parport/probe.c off by one error from Andy Chou

243  Drivers    SCSI       andmike@us.ibm.com
possiblecpqfcTSworker.c out of bounds bug from Andy Chou

244  Drivers    SCSI       andmike@us.ibm.com
Possible uninitialised ptr scsi bug from Andy Chou

246  Drivers    SCSI       andmike@us.ibm.com
Possible missing assert in sym_malloc.c from acc@cs.stanford.edu

247  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Possible bug in fbgen.c from Stanford Checker

248  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Possible bug in sstfb.c from Stanford Checker

249  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
uninitialized pointer in sstfb.c from Stanford Checker

252  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds bug in sb_mixer.c from Stanford Checker

253  Drivers    Sound      bugme-janitors@lists.osdl.org
another possible out of bounds error in sb_mixer.c from Stanford Checker

254  Drivers    Sound      bugme-janitors@lists.osdl.org
One more possible out of bounds error in sb_mixer.c from Stanford Checker

267  Other      Other      fdavis@si.rr.com
ver_linux script fails to give module-init-tools version

273  Other      Modules    bugme-janitors@lists.osdl.org
initrd refuses to build on raid0 system

283  Drivers    Serial     bugme-janitors@lists.osdl.org
Compile failure of drivers/char/isicom.c

288  IO/Stora   Block La   axboe@suse.de
BUG_ON in deadline I/O scheduler and write I/O not completing

289  Drivers    ISDN       fdavis@si.rr.com
Compile failure on drivers/isdn/i4l/isdn_net_lib.c

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

361  Drivers    Sound      bugme-janitors@lists.osdl.org
system hangs until keyrpress

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

370  Platform   i386       mbligh@aracnet.com
Kernel will not boot against Asus P4T533-C

371  Drivers    Other      bugme-janitors@lists.osdl.org
Badness in kobject_register at lib/kobject.c:152

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

380  Drivers    Sound      bugme-janitors@lists.osdl.org
SB16 compile errors

384  Other      Modules    bugme-janitors@lists.osdl.org
2.5.62 make modules *.ko has no CRC

386  Other      Other      bugme-janitors@lists.osdl.org
list of the worst stack offenders in the kernel (from Linus on lkml)

396  IO/Stora   Other      bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of ti

400  Other      Other      bugme-janitors@lists.osdl.org
Highpoint 370 triggers sleeping from illegal context debug code.

403  Drivers    USB        greg@kroah.com
USB controller locks up on boot.

411  Platform   i386       bugme-janitors@lists.osdl.org
unexpected IO-APIC on GA-7VAX

415  Drivers    Video(DR   bugme-janitors@lists.osdl.org
aty128fb.c fails to compile (logic error)

428  Drivers    Serial     rmk@arm.linux.org.uk
Not all serial ports listed in /proc/interrupts & /proc/ioports

441  Drivers    Console/   jsimmons@infradead.org
Badness in Riva framebuffer

443  Drivers    Sound      bugme-janitors@lists.osdl.org
warnings from sound/pci/cs46xx/cs46xx_lib.c:

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1&2/ac test tree

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

452  File Sys   XFS        hch@sgi.com
Null pointer dereference in iget_locked

456  Networki   IPV4       davem@vger.kernel.org
Apache test framework causes kernel panic in tcp_v4_get_port

458  Drivers    Sound      bugme-janitors@lists.osdl.org
computer crashes more or less randomly when using sounds more or less 
extensivel

460  Memory M   Slab All   akpm@digeo.com
kernel won't release slabcache without prodding

464  Power Ma   ACPI       andrew.grover@intel.com
2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned po

469  Networki   Other      acme@conectiva.com.br
/proc/net/dev byte counter wraps after 2^32

471  IO/Stora   MD         bugme-janitors@lists.osdl.org
Root on software raid don't boot on new 2.5 kernel since after 2.5.45

473  Alternat   mjb        mbligh@aracnet.com
2.5.65-mjb1 kernel BUG at mm/swap.c:299! on boot

477  Networki   Other      acme@conectiva.com.br
mii-tool and ethtool require root to query

481  Drivers    USB        greg@kroah.com
Annoying full pathname prefixes before messages during boot.

484  Networki   Other      acme@conectiva.com.br
Oops in packet_read_proc

485  Other      Other      bugme-janitors@lists.osdl.org
"make rpm" fails; no kernel-2.5.65/debugfiles.list

486  Drivers    Console/   jsimmons@infradead.org
compile failure in drivers/video/pm2fb.c

487  Drivers    Other      bugme-janitors@lists.osdl.org
hisax.ko needs unknown symbol            ^M

488  Drivers    USB        greg@kroah.com
host controller halted after unplugging usb mouse

490  Drivers    Input De   vojtech@suse.cz
psmouse.c fails detecting Microsoft PS/2 wheel mice

496  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
No ataraid support in 2.5.65?

511  Other      Modules    bugme-janitors@lists.osdl.org
CONFIG_PREEMPT / Invalid module format / version magic

513  Drivers    USB        vojtech@suse.cz
Wacom driver doesn't work...

515  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
kernel panics when bttv compiled in

521  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
cdrecord fails to see drive caps consistently when using ide-cd

528  Networki   IPV4       davem@vger.kernel.org
In /proc/net/route the default gateway isn't appear

537  Drivers    Sound      bugme-janitors@lists.osdl.org
Alsa EMU10K1 Audigy

541  Drivers    Network    andrew.grover@intel.com
3c59x.c: 3c556B Laptop Hurricane not correctly detected/run

542  IO/Stora   MD         bugme-janitors@lists.osdl.org
HPT372N didn't defined in linux/pci_ids.h

544  Process    Other      bugme-janitors@lists.osdl.org
bad: scheduling while atomic! warning on modprobe airo_cs

547  Platform   i386       gerrit@us.ibm.com
Hard hang encountered when DOTS was run against PostgreSQL (7.3.2-1) 
Linux kerne

548  Power Ma   ACPI       andrew.grover@intel.com
ACPI Battery: Not working on Acer Aspire / VIA Chipset

560  Drivers    Input De   vojtech@suse.cz
Wacom driver isn't working

569  Drivers    ISDN       bugme-janitors@lists.osdl.org
compile failure in drivers/isdn/hisax/sedlbauer.c

570  Drivers    ISDN       bugme-janitors@lists.osdl.org
compile failure in drivers/isdn/hisax/isurf.c

572  Power Ma   APM        apmbugs@rothwell.emu.id.au
Change compile-time option CONFIG_APM_RTS_IS_GMT to sysctl-tunable kernel 

576  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
IDE module loop

579  Drivers    ISDN       bugme-janitors@lists.osdl.org
isdn.ko needs unknown symbol group_send_sig_info

582  Power Ma   APM        apmbugs@rothwell.emu.id.au
network device does not survive laptop suspend

588  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
2.5.67 won't get the real partition table for hdb

591  Power Ma   ACPI       andrew.grover@intel.com
Compile error: depmod: *** Unresolved symbols /acpi/thermal.ko

593  Other      Other      bugme-janitors@lists.osdl.org
fb.h has syntax errors

595  Alternat   ac         alan@lxorguk.ukuu.org.uk
ide-cd stops recognizing cd-rw, starting with 2.5.67-ac1.

596  Process    Schedule   rml@tech9.net
process fork + shell exec is slower in 2.5.63

597  File Sys   ext2       akpm@digeo.com
simple file performance degradation on 2.5.63

599  Power Ma   ACPI       andrew.grover@intel.com
rtl8139 NIC don't work while CONFIG_ACPI=y

602  Drivers    USB        greg@kroah.com
warnings on hcd rmmod:  "dangling refs(N) to bus B"

609  Drivers    Input De   vojtech@suse.cz
Compilation error for adbhid.c [ppc]

610  Platform   PPC-32     bugme-janitors@lists.osdl.org
Missing include header causes agp compilation to fail on ppc32

611  Drivers    Sound      bugme-janitors@lists.osdl.org
keywest driver fails to compile due to i2c interface changes

612  IO/Stora   SCSI       andmike@us.ibm.com
aic7xxx driver hang

616  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
PCMCIA cards in cardbus sockets no longer suspended






