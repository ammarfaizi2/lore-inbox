Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268316AbTCFTLB>; Thu, 6 Mar 2003 14:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268321AbTCFTLB>; Thu, 6 Mar 2003 14:11:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:24553 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268316AbTCFTKy>; Thu, 6 Mar 2003 14:10:54 -0500
Message-ID: <3E679E65.7040002@us.ibm.com>
Date: Thu, 06 Mar 2003 14:15:49 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bugs sitting in the NEW state for more than 2 weeks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 88 bugs sitting in the NEW state for more than 2 weeks that 
don't appear
to have any activity.   35 of these bugs are owned by bugme-janitors 
which are good
candiates for anyone to work on.   Please check the bugs for before 
working on them
to see if they are still available.

Kernel Bug Tracker:  http://bugme.osdl.org

  48  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
APM suspend and PCMCIA not cooperating

  49  Drivers    Console/   jsimmons@infradead.org
register_console() called in illegal context

  69  Drivers    Console/   jsimmons@infradead.org
Framebuffer bug

  72  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

  79  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolling problem

110  File Sys   devfs      bugme-janitors@lists.osdl.org
Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UNIX98_PTYS

122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

135  Drivers    Sound      bugme-janitors@lists.osdl.org
SB16/Alsa doesn't work

142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

143  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
unable to read cd audio from atapi cdrom/cdrw/dvd device, possibly 
associated wi

145  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA: SB-AWE ISA detection fails

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

205  Drivers    Console/   jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

211  Drivers    USB        greg@kroah.com
Mounting a SM/CF reader does not work and does not return

219  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/tmscsim.c

220  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/AM53C974.c

232  Drivers    SCSI       andmike@us.ibm.com
block/cciss_scsi.c out of bounds according to stanford checker

235  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
ide/ide-lib.c array out of bound according to Andy Chou 
<acc@cs.stanford.edu>

236  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou <acc@cs.stanford.edu>

237  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou 
<acc@cs.stanford.edu>

238  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bounds from Andy Chou

239  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou

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

264  Drivers    Network    jgarzik@pobox.com
 >Hw. address read/write mismap&quot; when ejecting NE2000 Compatible 
pcmcia card

267  Other      Other      fdavis@si.rr.com
ver_linux script fails to give module-init-tools version

270  Drivers    Sound      bugme-janitors@lists.osdl.org
panic loading ALSA driver for cs4232

284  Drivers    IEEE1394   bcollins@debian.org
Compile failure in drivers/ieee1394/pcilynx.c

285  Drivers    I2O        alan@lxorguk.ukuu.org.uk
Compine failure on drivers/message/i2o/i2o_lan.c

288  IO/Stora   Block La   axboe@suse.de
BUG_ON in deadline I/O scheduler and write I/O not completing

291  Drivers    USB        greg@kroah.com
Compiled in USB does not implement shutdown

294  File Sys   devfs      bugme-janitors@lists.osdl.org
devfs_dealloc_unique_number() when not initialized

295  IO/Stora   Block La   axboe@suse.de
RD device shares elevator queue objects

297  Platform   i386       mbligh@aracnet.com
Booting kernel 2.5.57 and higher ends with failure

299  Power Ma   ACPI       andrew.grover@intel.com
Instant reboot w/ACPI enabled in 2.5.59

300  Alternat   mjb        mbligh@aracnet.com
Oops in 2.5.59-mjb1

301  IO/Stora   Block La   axboe@suse.de
ISA_DMA_THRESHOLD

308  Other      Other      bugme-janitors@lists.osdl.org
misplaced/extra semicolon

310  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
misplaced/extra semicolon drivers/media/video/w9966.c

313  Drivers    SCSI       andmike@us.ibm.com
misplaced/extra semicolon sym53c8xx

314  Drivers    USB        greg@kroah.com
misplaced/extra semicolon drivers/usb/serial/whiteheat.c

317  Drivers    Sound      bugme-janitors@lists.osdl.org
misplaced/extra semicolon sound/oss/cs46xx.c

320  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/ip2/i2lib.c

321  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator  drivers/char/ite_gpio.c

322  Drivers    Other      bugme-janitors@lists.osdl.org
double logical operator drivers/char/sx.c

324  Drivers    SCSI       andmike@us.ibm.com
double logical operator drivers/scsi/advansys.c

325  Alternat   mjb        mbligh@aracnet.com
Compile failure with 2.5.59-mjb4 with CONFIG_NUMA

326  Drivers    SCSI       andmike@us.ibm.com
BUG at drivers/scsi/scsi_error.c:1522! loading ServeRaid driver

329  Drivers    Input De   vojtech@suse.cz
wheel doesn't works on a usb mouse

332  Other      Other      bugme-janitors@lists.osdl.org
/etc/fstab LABEL for root partition not working

333  Platform   Alpha      rth@twiddle.net
typo in arch/alpha/kernel/signal.c

334  Platform   Alpha      rth@twiddle.net
missing init in arch/alpha/kernel/init_task.c

345  Drivers    SCSI       andmike@us.ibm.com
compile failure in drivers/scsi/inia100.c

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

353  Alternat   mm         akpm@digeo.com
Kernel panic on boot after realtek RTL-8139 ethernet intialization

354  Alternat   mm         akpm@digeo.com
Kernel panic on boot after realtek RTL-8139 ethernet intialization

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

370  Platform   i386       mbligh@aracnet.com
Kernel will not boot against Asus P4T533-C

379  Drivers    Sound      bugme-janitors@lists.osdl.org
VIA 8235 rear channel playback on front channels?

380  Drivers    Sound      bugme-janitors@lists.osdl.org
SB16 compile errors


