Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbTDVO7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbTDVO7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:59:07 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37052 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263192AbTDVO6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:58:41 -0400
Message-ID: <3EA55B25.5020603@us.ibm.com>
Date: Tue, 22 Apr 2003 11:09:25 -0400
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

There are 122 bugs sitting in the NEW state for more than two weeks
that don't appear to have any activity. 53 of these bugs are owned
by bugme-janitors which are good candidates for anyone to work on.
Please check the bugs before working on them to see if they are
still available.

Kernel Bug Tracker: http://bugme.osdl.org


  48  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
APM suspend and PCMCIA not cooperating

  69  Drivers    Console/   jsimmons@infradead.org
Framebuffer bug

  72  Drivers    Console/   jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

138  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
Build error: drivers/video/sis/sis_main.h:299: parse error before

142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

145  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA: SB-AWE ISA detection fails

153  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/riscom8.c

154  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/esp.c

155  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/specialix.c

160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

183  IO/Stora   SCSI       andmike@us.ibm.com
megaraid driver panics with IBM EXP300 enclosure

189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric formats

191  Platform   i386       akpm@digeo.com
Panic on shutdown

193  Other      Other      bugme-janitors@lists.osdl.org
sysrq umount bad ordering (real before loop)

199  Drivers    Flash/Me   dwmw2@infradead.org
compile failure on drivers/mtd/devices/blkmtd.c

205  Drivers    Console/   jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

207  Drivers    Console/   jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

209  Drivers    Console/   jsimmons@infradead.org
Matrox Framebuffer -- Does not compile

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

223  Drivers    USB        greg@kroah.com
"usbdevfs is depreciated" message always printed even when usbdevfs is not

228  Other      Other      bugme-janitors@lists.osdl.org
Make pdfdocs/psdocs/htmldoc fail in 2.5.54

232  Drivers    SCSI       andmike@us.ibm.com
block/cciss_scsi.c out of bounds according to stanford checker

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

288  IO/Stora   Block La   axboe@suse.de
BUG_ON in deadline I/O scheduler and write I/O not completing

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

349  IO/Stora   MD         bugme-janitors@lists.osdl.org
stripped MD0 splits requests incorrectly

354  Alternat   mm         akpm@digeo.com
Kernel panic on boot after realtek RTL-8139 ethernet intialization

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

386  Other      Other      bugme-janitors@lists.osdl.org
list of the worst stack offenders in the kernel (from Linus on lkml)

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

461  Memory M   Other      akpm@digeo.com
oops at kswapd

464  Power Ma   ACPI       andrew.grover@intel.com
2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!

465  IO/Stora   Other      bugme-janitors@lists.osdl.org
2.5.65: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() 
poisoned po

466  Drivers    IEEE1394   bcollins@debian.org
SBP2 driver doesn't appear to register a block device?

469  Networki   Other      acme@conectiva.com.br
/proc/net/dev byte counter wraps after 2^32

471  IO/Stora   MD         bugme-janitors@lists.osdl.org
Root on software raid don't boot on new 2.5 kernel since after 2.5.45

473  Alternat   mjb        mbligh@aracnet.com
2.5.65-mjb1 kernel BUG at mm/swap.c:299! on boot

477  Networki   Other      acme@conectiva.com.br
mii-tool and ethtool require root to query

478  Memory M   Slab All   akpm@digeo.com
reiserfs panics overnight during running cron jobs due to slab corruption.

481  Drivers    USB        greg@kroah.com
Annoying full pathname prefixes before messages during boot.

482  Memory M   Slab All   akpm@digeo.com
slab error in check_poison_obj(): cache `task_struct': object was 
modified after

484  Networki   Other      acme@conectiva.com.br
Oops in packet_read_proc

485  Other      Other      bugme-janitors@lists.osdl.org
"make rpm" fails; no kernel-2.5.65/debugfiles.list

486  Drivers    Console/   jsimmons@infradead.org
compile failure in drivers/video/pm2fb.c

488  Drivers    USB        greg@kroah.com
host controller halted after unplugging usb mouse

489  Power Ma   ACPI       andrew.grover@intel.com
Boot hang on HP ZE4145

490  Drivers    Input De   vojtech@suse.cz
psmouse.c fails detecting Microsoft PS/2 wheel mice

492  Drivers    SCSI       andmike@us.ibm.com
Zip drive parallel-port driver causes segfault in 2.5.x

496  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
No ataraid support in 2.5.65?

497  Networki   Netfilte   laforge@gnumonks.org
conntrack related slab corruption.

501  Drivers    Console/   jsimmons@infradead.org
sleeping function in illegal context

502  Drivers    Console/   jsimmons@infradead.org
Broken cursor when using neofb

511  Other      Modules    bugme-janitors@lists.osdl.org
CONFIG_PREEMPT / Invalid module format / version magic

514  Memory M   Other      akpm@digeo.com
Oops in mga_vm_shm_close during X shutdown

515  Drivers    Video(Ot   bugme-janitors@lists.osdl.org
kernel panics when bttv compiled in

517  Drivers    Console/   jsimmons@infradead.org
Can't compile 2.5.66 w/i810fb support

518  Drivers    Console/   jsimmons@infradead.org
unable to handle kernel paging request

521  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
cdrecord fails to see drive caps consistently when using ide-cd

522  Alternat   mm         akpm@digeo.com
Booting noapic leads to a ton of APIC errors

523  Alternat   mm         akpm@digeo.com
MCE on boot

525  Alternat   mm         akpm@digeo.com
JFS sucks (wheee FS corruption- rant and/or near-useless bug report)

528  Networki   IPV4       davem@vger.kernel.org
In /proc/net/route the default gateway isn't appear

530  Drivers    Other      bugme-janitors@lists.osdl.org
dma not enabled for IDE hard drives

531  IO/Stora   Other      bugme-janitors@lists.osdl.org
cdrom ioctl CDROM_SEND_PACKET broken

537  Drivers    Sound      bugme-janitors@lists.osdl.org
Alsa EMU10K1 Audigy

539  Drivers    Input De   vojtech@suse.cz
mouse hyper sensitive, and (almost) no 3-button emulation

542  IO/Stora   MD         bugme-janitors@lists.osdl.org
HPT372N didn't defined in linux/pci_ids.h

544  Process    Other      bugme-janitors@lists.osdl.org
bad: scheduling while atomic! warning on modprobe airo_cs

546  IO/Stora   Other      bugme-janitors@lists.osdl.org
Close notification in poll/select never arrives

548  Power Ma   ACPI       andrew.grover@intel.com
ACPI Battery: Not working on Acer Aspire / VIA Chipset




