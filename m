Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbTDCPnv>; Thu, 3 Apr 2003 10:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbTDCPnv>; Thu, 3 Apr 2003 10:43:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31687 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261276AbTDCPnn>;
	Thu, 3 Apr 2003 10:43:43 -0500
Message-ID: <3E8C5851.6080200@us.ibm.com>
Date: Thu, 03 Apr 2003 10:50:41 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Bugs sitting in the NEW state for more than 2 weeks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 116 bugs sitting in the NEW state for more than two weeks
that don't appear to have any activity. 53 of these bugs are owned
by bugme-janitors which are good candidates for anyone to work on.
Please check the bugs before working on them to see if they are
still available.

Kernel Bug Tracker: http://bugme.osdl.org

  48  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
APM suspend and PCMCIA not cooperating

  49  Drivers    Console/   jsimmons@infradead.org
register_console() called in illegal context

  69  Drivers    Console/   jsimmons@infradead.org
Framebuffer bug

  72  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

135  Drivers    Sound      bugme-janitors@lists.osdl.org
SB16/Alsa doesn't work

138  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Build error: drivers/video/sis/sis_main.h:299: parse error before >sisfbinfo

142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

143  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated wi

145  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA: SB-AWE ISA detection fails

153  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/riscom8.c

155  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/specialix.c

160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

161  Drivers    Console/   jsimmons@infradead.org
VESAfb in 2.5 somehow influences X resolution.

183  IO/Stora   SCSI       andmike@us.ibm.com
megaraid driver panics with IBM EXP300 enclosure

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

191 Platform i386 akpm@digeo.com
Panic on shutdown

192 IO/Stora Block La axboe@suse.de
loop.c IV calculation is broken since 2.4.x

193 Other Other bugme-janitors@lists.osdl.org
sysrq umount bad ordering (real before loop)

199 Drivers Flash/Me dwmw2@infradead.org
compile failure on drivers/mtd/devices/blkmtd.c

201 Drivers Network jgarzik@pobox.com
compile failure on drivers/net/fc/iph5526.c

203 Drivers Network jgarzik@pobox.com
compile failure on drivers/net/wan/sdlamain.c

204 Drivers Network jgarzik@pobox.com
compile failure on drivers/net/rcpci45.c

205 Drivers Console/ jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

207 Drivers Console/ jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

209 Drivers Console/ jsimmons@infradead.org
Matrox Framebuffer -- Does not compile

213 Drivers SCSI andmike@us.ibm.com
compile failure in drivers/scsi/ini9100u.c

215 Drivers SCSI andmike@us.ibm.com
compile failure in drivers/scsi/pci2000.c

216 Drivers SCSI andmike@us.ibm.com
compile failure in drivers/scsi/pci2220i.c

217 Drivers SCSI andmike@us.ibm.com
compile failure in drivers/scsi/dpt_i2o.c

220 Drivers SCSI andmike@us.ibm.com
compile failure in drivers/scsi/AM53C974.c 

228 Other Other bugme-janitors@lists.osdl.org
Make pdfdocs/psdocs/htmldoc fail in 2.5.54

232 Drivers SCSI andmike@us.ibm.com
block/cciss_scsi.c out of bounds according to stanford checker

233 Drivers Other bugme-janitors@lists.osdl.org
cdrom/cdu31a.c Out of bounds according to Andy Chou

235 IO/Stora IDE alan@lxorguk.ukuu.org.uk
ide/ide-lib.c array out of bound according to Andy Chou

236 Drivers Video(Ot bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou

237 Drivers Video(Ot bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou

238 Drivers Video(Ot bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds. From Andy Chou

239 Drivers Video(Ot bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou

240 Drivers Parallel bugme-janitors@lists.osdl.org
possible parport/probe.c off by one error from Andy Chou

243 Drivers SCSI andmike@us.ibm.com
possiblecpqfcTSworker.c out of bounds bug from Andy Chou

244 Drivers SCSI andmike@us.ibm.com
Possible uninitialised ptr scsi bug from Andy Chou

246 Drivers SCSI andmike@us.ibm.com
Possible missing assert in sym_malloc.c from acc@cs.stanford.edu

247 Drivers Video(Ot bugme-janitors@lists.osdl.org
Possible bug in fbgen.c from Stanford Checker

248 Drivers Video(Ot bugme-janitors@lists.osdl.org
Possible bug in sstfb.c from Stanford Checker

249 Drivers Video(Ot bugme-janitors@lists.osdl.org
uninitialized pointer in sstfb.c from Stanford Checker
 
252  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds bug in sb_mixer.c from Stanford Checker

253  Drivers    Sound      bugme-janitors@lists.osdl.org
another possible out of bounds error in sb_mixer.c from Stanford Checker

254  Drivers    Sound      bugme-janitors@lists.osdl.org
One more possible out of bounds error in sb_mixer.c from Stanford Checker

255  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds error in ac97_patch.c from Stanford Checker

263  Drivers    Console/   jsimmons@infradead.org
neofb null pointer dereference

264  Drivers    Network    jgarzik@pobox.com
 >Hw. address read/write mismap&quot; when ejecting NE2000 Compatible 
pcmcia card

267  Other      Other      fdavis@si.rr.com
ver_linux script fails to give module-init-tools version

270  Drivers    Sound      bugme-janitors@lists.osdl.org
panic loading ALSA driver for cs4232

273  Other      Modules    bugme-janitors@lists.osdl.org
initrd refuses to build on raid0 system

283  Drivers    Serial     bugme-janitors@lists.osdl.org
Compile failure of drivers/char/isicom.c

284  Drivers    IEEE1394   bcollins@debian.org
Compile failure in drivers/ieee1394/pcilynx.c

288  IO/Stora   Block La   axboe@suse.de
BUG_ON in deadline I/O scheduler and write I/O not completing

289  Drivers    Other      fdavis@si.rr.com
Compile failure on drivers/isdn/i4l/isdn_net_lib.c

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

345  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/inia100.c

346  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/cpqfcTSinit.c

349  IO/Stora   MD         bugme-janitors@lists.osdl.org
stripped MD0 splits requests incorrectly

351  Drivers    Network    jgarzik@pobox.com
duplicated messages in tg3 startup

352  Other      Other      bugme-janitors@lists.osdl.org
Unneccessary includes of linux/version.h

354  Alternat   mm         akpm@digeo.com
Kernel panic on boot after realtek RTL-8139 ethernet intialization

361  Drivers    Sound      bugme-janitors@lists.osdl.org
system hangs until keyrpress

365  IO/Stora   MD         bugme-janitors@lists.osdl.org
Raid-0 causes kernel BUG at drivers/block/ll_rw_blk.c:1996

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

369  Drivers    Sound      bugme-janitors@lists.osdl.org
opl3sa2.c fails to compile because on PNP error

370  Platform   i386       mbligh@aracnet.com
Kernel will not boot against Asus P4T533-C

371  Drivers    Other      bugme-janitors@lists.osdl.org
Badness in kobject_register at lib/kobject.c:152

377  Drivers    Sound      bugme-janitors@lists.osdl.org
sound/isa/ad1816a/ad1816a.c doesn't compile #ifdef __ISAPNP__

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

384  Networki   Other      jgarzik@pobox.com
2.5.62 make modules *.ko has no CRC

386  Other      Other      bugme-janitors@lists.osdl.org
list of the worst stack offenders in the kernel (from Linus on lkml)

387  Other      Other      bugme-janitors@lists.osdl.org
poll on usb device does not return immediatly when device is unplugged

388  Other      Other      bugme-janitors@lists.osdl.org
2.5.60/ioctl on usb device returns wrong length

395  Drivers    Sound      bugme-janitors@lists.osdl.org
No sound with ESS Maestro3

396  IO/Stora   Other      bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of ti

400  Other      Other      bugme-janitors@lists.osdl.org
Highpoint 370 triggers sleeping from illegal context debug code.

411  Platform   i386       bugme-janitors@lists.osdl.org
unexpected IO-APIC on GA-7VAX

415  Drivers    Video(DR   bugme-janitors@lists.osdl.org
aty128fb.c fails to compile (logic error)

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

420  Networki   IPV4       davem@vger.kernel.org
Divide by zero (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)

428  Drivers    Serial     rmk@arm.linux.org.uk
Not all serial ports listed in /proc/interrupts > /proc/ioports

431  Process    Other      bugme-janitors@lists.osdl.org
kernel BUG at include/linux/smp_lock.h:53!

437  Drivers    Network    jgarzik@pobox.com
compile failure in drivers/net/tokenring/tms380tr.c

438  Drivers    SCSI       andmike@us.ibm.com
aic7xxx_old does not boot

441  Drivers    Console/   jsimmons@infradead.org
Badness in Riva framebuffer

443  Drivers    Sound      bugme-janitors@lists.osdl.org
warnings from sound/pci/cs46xx/cs46xx_lib.c:

444  Drivers    Sound      bugme-janitors@lists.osdl.org
bug@snd_ctl_release

445  Drivers    Console/   jsimmons@infradead.org
cat /dev/fb1 -> null pointer @ fb_open

446  Alternat   ac         alan@lxorguk.ukuu.org.uk
IDE ZIP does not work on 2.4.21-pre5-ac1>2/ac test tree

449  File Sys   SysFS      mochel@osdl.org
Kernel BUG when tun device is closed (oops attached)

450  Networki   Other      acme@conectiva.com.br
PPP (PPPoE) causes OOPS on interface initialization, 2.5.64

452  File Sys   XFS        hch@sgi.com
Null pointer dereference in iget_locked

453  Alternat   mm         akpm@digeo.com
unexpected IO-APIC
 
456  Networki   IPV4       davem@vger.kernel.org
Apache test framework causes kernel panic in tcp_v4_get_port

457  File Sys   devfs      bugme-janitors@lists.osdl.org
Using Raid0 and devfs.. I get VFS unable to mount root

458  Drivers    Sound      bugme-janitors@lists.osdl.org
computer crashes more or less randomly when using sounds more or less 
extensivel

459  Drivers    Sound      bugme-janitors@lists.osdl.org
error compiling sound/isa/es18xx

460  Memory M   Slab All   akpm@digeo.com
kernel won't release slabcache without prodding

462  Drivers    PNP        ambx1@neo.rr.com
PNPBios blows up hard during boot

463  Drivers    Network    jgarzik@pobox.com
Transmit counts always zero, 2 eth cards.

464  Power Ma   ACPI       andrew.grover@intel.com
2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned po

466  Drivers    IEEE1394   bcollins@debian.org
SBP2 driver doesn't appear to register a block device?

469  Networki   Other      acme@conectiva.com.br
/proc/net/dev byte counter wraps after 2^32
  
    
 

