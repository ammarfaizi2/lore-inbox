Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbTCTO3Q>; Thu, 20 Mar 2003 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCTO3Q>; Thu, 20 Mar 2003 09:29:16 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37772 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261484AbTCTO3J>;
	Thu, 20 Mar 2003 09:29:09 -0500
Message-ID: <3E79D1AD.5080803@us.ibm.com>
Date: Thu, 20 Mar 2003 09:35:25 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Bugs sitting in the NEW state for more than two weeks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 101 bugs sitting in the NEW state for more than 2 weeks
that don't appear to have any activity. 48 of these bugs are owned
by bugme-janitors which are good candidates for anyone to work on.
Please check the bugs for before working on them to see if they are
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

153  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/riscom8.c

154  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/esp.c

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

191  Platform   i386       akpm@digeo.com
Panic on shutdown

192  IO/Stora   Block La   axboe@suse.de
loop.c IV calculation is broken since 2.4.x

193  Other      Other      bugme-janitors@lists.osdl.org
sysrq umount bad ordering (real before loop)

199  Drivers    Flash/Me   dwmw2@infradead.org
compile failure on drivers/mtd/devices/blkmtd.c

201  Drivers    Network    jgarzik@pobox.com
compile failure on drivers/net/fc/iph5526.c

203  Drivers    Network    jgarzik@pobox.com
compile failure on drivers/net/wan/sdlamain.c

204  Drivers    Network    jgarzik@pobox.com
compile failure on drivers/net/rcpci45.c

207  Drivers    Console/   jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

211  Drivers    USB        greg@kroah.com
Mounting a SM/CF reader does not work and does not return

213  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/ini9100u.c

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

221  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/gdth.c

228  Other      Other      bugme-janitors@lists.osdl.org
Make pdfdocs/psdocs/htmldoc fail in 2.5.54

232  Drivers    SCSI       andmike@us.ibm.com
block/cciss_scsi.c out of bounds according to stanford checker

233  Drivers    Other      bugme-janitors@lists.osdl.org
cdrom/cdu31a.c Out of bounds according to Andy Chou <acc@CS.Stanford.EDU>

235  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
ide/ide-lib.c array out of bound according to Andy Chou 
<acc@cs.stanford.edu>

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

255  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds error in ac97_patch.c from Stanford Checker

263  Drivers    Console/   jsimmons@infradead.org
neofb null pointer dereference

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

291  Drivers    USB        greg@kroah.com
Compiled in USB does not implement shutdown

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

346  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/cpqfcTSinit.c

349  IO/Stora   MD         bugme-janitors@lists.osdl.org
stripped MD0 splits requests incorrectly

350  Process    Schedule   rml@tech9.net
i386 context switch very slow compared to 2.4 due to wrmsr (performance)

351  Drivers    Network    jgarzik@pobox.com
duplicated messages in tg3 startup

352  Other      Other      bugme-janitors@lists.osdl.org
Unneccessary includes of linux/version.h

361  Drivers    Sound      bugme-janitors@lists.osdl.org
system hangs until keyrpress

362  Drivers    USB        greg@kroah.com
USB Mass Storage hangs trying to mount an Smartmedia Card in ICS-36 card 
reader

365  IO/Stora   MD         bugme-janitors@lists.osdl.org
Raid-0 causes kernel BUG at drivers/block/ll_rw_blk.c:1996

368  Drivers    Console/   jsimmons@infradead.org
Permedia 3 driver broken

369  Drivers    Sound      bugme-janitors@lists.osdl.org
opl3sa2.c fails to compile because on PNP error

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

387 Other Other bugme-janitors@lists.osdl.org
poll on usb device does not return immediatly when device is unplugged

388 Other Other bugme-janitors@lists.osdl.org
2.5.60/ioctl on usb device returns wrong length

390 Other Other bugme-janitors@lists.osdl.org
System hang with MySql workload

392 Platform i386 mbligh@aracnet.com
unexpected IO-APIC, please file a report at...

395 Drivers Sound bugme-janitors@lists.osdl.org
No sound with ESS Maestro3

396 IO/Stora Other bugme-janitors@lists.osdl.org
The kernel keeps trying to read a bad floppy disk sector a infinite 
number of

402  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
TV output appears offset from xawtv window.

403  Drivers    USB        greg@kroah.com
USB controller locks up on boot.

410  Platform   i386       mbligh@aracnet.com
unexpected IO-APIC, please file a report at http://bugzilla.kernel.org

415  Drivers    Video(DR   bugme-janitors@lists.osdl.org
aty128fb.c fails to compile (logic error)

417  File Sys   ext3       akpm@digeo.com
htree much slower than regular ext3

418  Drivers    USB        greg@kroah.com
Bad use of GFP_DMA

420  Networki   IPV4       davem@vger.kernel.org
Divide by zero (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)

426  Other      Other      bugme-janitors@lists.osdl.org
i can not compile kernel

429  Drivers    Other      bugme-janitors@lists.osdl.org
Device names cut off in sysfs and /proc/ioports and other places

431  Process    Other      bugme-janitors@lists.osdl.org
kernel BUG at include/linux/smp_lock.h:53!

437  Drivers    Network    jgarzik@pobox.com
compile failure in drivers/net/tokenring/tms380tr.c

438  Drivers    SCSI       andmike@us.ibm.com
aic7xxx_old does not boot

439  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
2.5.63-bk5-7 IDE disk hangs with multiple disks

