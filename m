Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267777AbTAHR5R>; Wed, 8 Jan 2003 12:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTAHR5R>; Wed, 8 Jan 2003 12:57:17 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:41135 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S267777AbTAHR5L>; Wed, 8 Jan 2003 12:57:11 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 08 Jan 2003 13:05:12 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  January 8, 2002
Message-ID: <3E1C2208.6727.5370CB@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [66.171.96.253] at Wed, 8 Jan 2003 12:05:34 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of note this week the merge of lm_sensors (drivers for health monitoring 
hardware) and support for AGP 3.0.  
See http://www.kernelnewbies.org/status/ for details.

Also, many more bugs have been entered in bugzilla, mostly compile problems 
for broken drivers (http://bugzilla.kernel.org/)

-- Guillaume


List of the bugs up for adoption (i.e. noone is working on):
If you want to work on a bug, it is polite to mark it as 'Assigned' so 
other people know you are working on it.

18  nor  vojtech@suse.cz  OPEN   Synaptics touchpad driver  
46  nor  vojtech@suse.cz  OPEN   ide-scsi causing (Two mice: unwanted double-clicks & erra...  
48  nor  bugme-janitors@lists.osdl.org  OPEN   APM suspend and PCMCIA not cooperating  
49  nor  jsimmons@infradead.org  OPEN   register_console() called in illegal context  
54  nor  bugme-janitors@lists.osdl.org  OPEN   100% reproduceable "null TTY for (####) in tty_fasync"  
58  nor  bcollins@debian.org  OPEN   OHCI-1394: sleeping function called from illegal context ...  
69  nor  jsimmons@infradead.org  OPEN   Framebuffer bug  
72  nor  jsimmons@infradead.org  OPEN   Framebuffer scrolls at the wrong times/places  
79  nor  jsimmons@infradead.org  OPEN   Framebuffer scrolling problem  
93  nor  khoa@us.ibm.com  OPEN   2.5.48 bttv module compile error  
94  nor  bugme-janitors@lists.osdl.org  OPEN   file remain locked after sapdb process exist.  
104  nor  bugme-janitors@lists.osdl.org  OPEN   MIPS fails to build: asm/thread_info.h doesn't exist  
110  nor  bugme-janitors@lists.osdl.org  OPEN   Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UN...  
115  nor  bugme-janitors@lists.osdl.org  OPEN   Kernel modules won't load  
122  nor  bugme-janitors@lists.osdl.org  OPEN   emu10k1 OSS troubles  
126  nor  vojtech@suse.cz  OPEN   bzImage build failure on input devices support as module  
134  nor  bugme-janitors@lists.osdl.org  OPEN   2.5.50 breaks pcmcia cards  
135  nor  bugme-janitors@lists.osdl.org  OPEN   SB16/Alsa doesn't work  
138  nor  bugme-janitors@lists.osdl.org  OPEN   Build error: drivers/video/sis/sis_main.h:299: parse erro...  
142  low  bugme-janitors@lists.osdl.org  OPEN   problem with ver_linux script and procps version  
143  nor  alan@lxorguk.ukuu.org.uk  OPEN   unable to read cd audio from atapi cdrom/cdrw/dvd device,...  
145  nor  bugme-janitors@lists.osdl.org  OPEN   ALSA: SB-AWE ISA detection fails  
149  nor  vojtech@suse.cz  OPEN   Laptop with touchpad and "pointer". Pointer never works  
153  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/char/riscom8.c  
154  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/char/esp.c  
155  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/char/specialix.c  
157  hig  bugme-janitors@lists.osdl.org  OPEN   Makefile bug? sound/synth/emux/built-in.o  
158  nor  bugme-janitors@lists.osdl.org  OPEN   depmod should be in README  
159  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/isdn/i4l/isdn_net_lib.c  
160  nor  jgarzik@pobox.com  OPEN   With 2 different nic on one system, dhcp configuration fails  
161  nor  jsimmons@infradead.org  OPEN   VESAfb in 2.5 somehow influences X resolution.  
162  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/media/video/bttv-cards.c  
171  nor  vojtech@suse.cz  OPEN   2.5.51 at kb driver leaves kb ib state that prevents (sof...  
172  nor  jsimmons@infradead.org  OPEN   tdfxfb.c can't be compiled  
174  nor  bugme-janitors@lists.osdl.org  OPEN   link failure in function dvb_generic_ioctl: undefined ref...  
179  nor  bugme-janitors@lists.osdl.org  OPEN   boot from 21 sec/track floppy  
183  nor  andmike@us.ibm.com  OPEN   megaraid driver panics with IBM EXP300 enclosure  
184  nor  zippel@linux-m68k.org  OPEN   Unresolved symbols in crypto modules.  
189  nor  bugme-janitors@lists.osdl.org  OPEN   sscanf in lib/vsprintf.c ignores field width for numeric ...  
191  nor  akpm@digeo.com  OPEN   Panic on shutdown  
192  nor  axboe@suse.de  OPEN   loop.c IV calculation is broken since 2.4.x  
193  nor  bugme-janitors@lists.osdl.org  OPEN   sysrq umount bad ordering (real before loop)  
195  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/media/video/zr36067.c  
196  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/media/video/stradis.c  
197  nor  bugme-janitors@lists.osdl.org  OPEN   compile failure on drivers/media/video/tda9887.o  
198  nor  alan@lxorguk.ukuu.org.uk  OPEN   compile failure on drivers/message/i2o/i2o_lan.c  
199  nor  dwmw2@infradead.org  OPEN   compile failure on drivers/mtd/devices/blkmtd.c  
200  nor  dwmw2@infradead.org  OPEN   compile failure on drivers/mtd/ftl.c  
201  nor  jgarzik@pobox.com  OPEN   compile failure on drivers/net/fc/iph5526.c  
203  nor  jgarzik@pobox.com  OPEN   compile failure on drivers/net/wan/sdlamain.c  
204  nor  jgarzik@pobox.com  OPEN   compile failure on drivers/net/rcpci45.c  
205  low  jsimmons@infradead.org  OPEN   gpm mouse cursor flips chars on framebuffer console  
206  nor  jsimmons@infradead.org  OPEN   broken colors on framebuffer console  
207  blo  jsimmons@infradead.org  OPEN   Cirrus Logic Framebuffer -- Does not compile  
208  nor  jgarzik@pobox.com  OPEN   Build error in aironet4500_core.c  
209  nor  jsimmons@infradead.org  OPEN   Matrox Framebuffer -- Does not compile  
211  nor  greg@kroah.com  OPEN   Mounting a SM/CF reader does not work and does not return  
213  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/ini9100u.c  
214  nor  bugme-janitors@lists.osdl.org  OPEN   Incorrect disabling of mate drive  
215  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/pci2000.c  
216  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/pci2220i.c  
217  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/dpt_i2o.c  
218  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/53c7,8xx.c  
219  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/tmscsim.c  
220  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/AM53C974.c  
221  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/gdth.c  
222  nor  andmike@us.ibm.com  OPEN   compile failure in drivers/scsi/eata_dma.c  
223  nor  greg@kroah.com  OPEN   "usbdevfs is depreciated" message always printed even whe...  
228  low  bugme-janitors@lists.osdl.org  OPEN   Make pdfdocs/psdocs/htmldoc fail in 2.5.54  
232  nor  andmike@us.ibm.com  OPEN   out of bounds according to stanford checker  
233  nor  bugme-janitors@lists.osdl.org  OPEN   Out of bounds according to Andy Chou <acc@CS.Stanford.EDU>  
234  nor  bugme-janitors@lists.osdl.org  OPEN   Out of bounds according to Andy Chou <acc@cs.stanford.edu>  
235  nor  alan@lxorguk.ukuu.org.uk  OPEN   array out of bound according to Andy Chou <acc@cs.stanfor...  
236  nor  bugme-janitors@lists.osdl.org  OPEN   conversion error from Andy Chou <acc@cs.stanford.edu>  
237  low  bugme-janitors@lists.osdl.org  OPEN   buffer out of bounds from Andy Chou <acc@cs.stanford.edu>  
238  low  bugme-janitors@lists.osdl.org  OPEN   buffer out of bounds. From Andy Chou <acc@cs.stanford.edu>  
239  low  bugme-janitors@lists.osdl.org  OPEN   buffer out of bounds from Andy Chou <acc@cs.stanford.edu>  
240  low  bugme-janitors@lists.osdl.org  OPEN   possible off by one error from Andy Chou <acc@cs.stanford...  
241  low  ambx1@neo.rr.com  OPEN   buffer out of bounds from Andy Chou <acc@cs.stanford.edu>  
242  low  andmike@us.ibm.com  OPEN   buffer out of bounds in aha1542.c from Andy Chou <acc@cs....  
243  low  andmike@us.ibm.com  OPEN   possible out of bounds bug from Andy Chou <acc@cs.stanfor...  
244  low  andmike@us.ibm.com  OPEN   Possible bug from Andy Chou <acc@cs.stanford.edu>  
245  low  andmike@us.ibm.com  OPEN   Possible out of bound error in sym53c416.c from Andy Chou...  
246  low  andmike@us.ibm.com  OPEN   Possible missing assert in sym_malloc.c from acc@cs.stanf...  
247  low  bugme-janitors@lists.osdl.org  OPEN   Possible bug in fbgen.c from Stanford Checker  
248  low  bugme-janitors@lists.osdl.org  OPEN   Possible bug in sstfb.c from Stanford Checker  
249  nor  bugme-janitors@lists.osdl.org  OPEN   uninitialized pointer in sstfb.c from Stanford Checker  
250  low  bugme-janitors@lists.osdl.org  OPEN   Possible out of bounds error from Stanford Checker  
252  low  bugme-janitors@lists.osdl.org  OPEN   Possible out of bounds bug in sb_mixer.c from Stanford Ch...  
253  low  bugme-janitors@lists.osdl.org  OPEN   another possible out of bounds error in sb_mixer.c from S...  
254  low  bugme-janitors@lists.osdl.org  OPEN   One more possible out of bounds error in sb_mixer.c from ...  
255  low  bugme-janitors@lists.osdl.org  OPEN   Possible out of bounds error in ac97_patch.c from Stanfor...  
256  nor  jgarzik@pobox.com  OPEN   3c509.c wants updating to new pnp model  
 
List of bugs that have been claimed (i.e. someone is working on):
5  nor  mbligh@aracnet.com  ASSI   64GB highmem BUG()  
7  nor  willy@debian.org  ASSI   file lock accounting broken  
8  low  alan@lxorguk.ukuu.org.uk  ASSI   i2o_scsi does not handle reset properly  
9  nor  dbrownell@users.sourceforge...  ASSI   Ehci do not leave system in a sensible state for bios on ...  
10  hig  andrew.grover@intel.com  ASSI   USB HCs may have improper interrupt configuration with AC...  
14  nor  davej@codemonkey.org.uk  ASSI   No dri : unsupported Via chipset (device id: 3189)  
15  nor  alan@lxorguk.ukuu.org.uk  ASSI   No dma on first hard drive  
16  nor  willy@debian.org  ASSI   reproduceable oops in lock_get_status  
29  low  akpm@digeo.com  ASSI   Debug: sleeping function called from illegal context at m...  
36  nor  andmike@us.ibm.com  ASSI   Long tape rewind causes abort on aic7xxx  
37  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE problems on old pre-PCI HW  
39  nor  alan@lxorguk.ukuu.org.uk  ASSI   undefined reference to `boot_gdt_table'  
43  nor  jgarzik@pobox.com  ASSI   e100 drivers crashes on non cache-coherent platforms  
44  blo  khoa@us.ibm.com  ASSI   radeonfb does not compile at all - seems incomplete? or w...  
51  nor  paul@laufernet.com  ASSI   isapnp does not register devices in /proc/isapnp  
52  nor  andmike@us.ibm.com  ASSI   aic7xxx driver fails to boot on netfinity 7000  
53  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE cd-rom I/O error  
63  nor  wli@holomorphy.com  ASSI   compile error with CONFIG_HUGETLB_PAGE yes  
66  blo  zaitcev@yahoo.com  ASSI   SMP Kernel Compile for Sparc32 fails  
71  hig  andrew.grover@intel.com  ASSI   RTL8100BL (8139) do not work on acpi UP without local apic  
83  low  zippel@linux-m68k.org  ASSI   Wish: ability to quickly cycle through (NEW) config options  
100  nor  johnstul@us.ibm.com  ASSI   LTP - gettimeofday02 fails (time is going backwards)  
105  nor  johnstul@us.ibm.com  ASSI   gettimeofday cripples system running with notsc  
106  nor  mochel@osdl.org  ASSI   sysfs hierarchy can begin to disintegrate  
111  hig  wli@holomorphy.com  ASSI   hugetlbfs does not align pages  
113  hig  alan@lxorguk.ukuu.org.uk  ASSI   CMD649 or ALI15X3 problem under 2.5.49 and since many pre...  
118  blo  alan@lxorguk.ukuu.org.uk  ASSI   Load IDE-SCSI module causes OOPS in 2.5.49  
119  nor  andrew.grover@intel.com  ASSI   2.5.49 - Dell Latitude weirdness at shutdown  
123  blo  alan@lxorguk.ukuu.org.uk  ASSI   SiL 680 IDE controller has "issues"  
130  hig  green@namesys.com  ASSI   problems mounting root partition with 2.5.48+ kernels  
131  nor  alan@lxorguk.ukuu.org.uk  ASSI   "hda: lost interrupt"; "hda: dma_intr: bad DMA status" on...  
132  nor  acme@conectiva.com.br  ASSI   windows ip check ARP packet replied by kernel when proxy_...  
136  nor  akpm@digeo.com  ASSI   FSID returned from statvfs always 0  
140  nor  andmike@us.ibm.com  ASSI   isp1020 driver reports error  
146  low  akpm@digeo.com  ASSI   Assertion failure in do_get_write_access() at fs/jbd/tra...  
150  nor  ambx1@neo.rr.com  ASSI   [PNP][2.5] IDE Detection problems (wrong IRQ and wrong ID...  
151  nor  jejb@hansenpartnership.com  ASSI   compile failure on drivers/block/ps2esdi.c  
156  nor  alan@lxorguk.ukuu.org.uk  ASSI   compile failure on drivers/ide/pci/nvidia.c  
165  nor  jgarzik@pobox.com  ASSI   Kernel crashes after stop network and remove e100.  
166  nor  jgarzik@pobox.com  ASSI   e100 spits out strange message during startup.  
167  nor  fdavis@si.rr.com  ASSI   compile failure on drivers/media/video/zr36120.c  
168  nor  fdavis@si.rr.com  ASSI   compile failure on drivers/media/video/saa7185.c  
169  nor  fdavis@si.rr.com  ASSI   compile failure on drivers/media/video/bt819.c  
170  low  akpm@digeo.com  ASSI   poisoned oops in dump_orphan_list  
185  low  alan@lxorguk.ukuu.org.uk  ASSI   mwave init yields: bad: scheduling while atomic!  
188  nor  wli@holomorphy.com  ASSI   proc_pid_readdir() holds the tasklist_lock for excessive ...  


