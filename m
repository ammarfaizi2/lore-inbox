Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbSLREsw>; Tue, 17 Dec 2002 23:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbSLREsw>; Tue, 17 Dec 2002 23:48:52 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:31714 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S267152AbSLREss>; Tue, 17 Dec 2002 23:48:48 -0500
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 17 Dec 2002 23:56:29 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  December 18, 2002
Message-ID: <3DFFB9AD.8438.9AB3D1E@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out001.verizon.net from [64.152.17.166] at Tue, 17 Dec 2002 22:56:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing new in the kernel status list this week. 
A lot of stabilization work and bug fixes.

In case you want to check it out anyway, here the URL again:
  http://www.kernelnewbies.org/status/

It also looks like the bug database is working out well, 
more than half the bugs entered so far have been resolved.
Cheers,

-- Guillaume


----------------------

Below a snapshot of the bugzilla database, ordered by severity
(see http://bugzilla.kernel.org/ for full details)

44  blo  khoa@us.ibm.com  OPEN   radeonfb does not compile at all - seems incomplete? or w...  
118  blo  mbligh@aracnet.com  OPEN   Load IDE-SCSI module causes OOPS in 2.5.49  
66  blo  zaitcev@yahoo.com  ASSI   SMP Kernel Compile for Sparc32 fails  
123  blo  alan@lxorguk.ukuu.org.uk  ASSI   SiL 680 IDE controller has "issues"  
157  hig  mbligh@aracnet.com  OPEN   Makefile bug? sound/synth/emux/built-in.o  
180  hig  davej@codemonkey.org.uk  OPEN   Broken agpgart on i815 (maybe other ICH too)  
10  hig  andrew.grover@intel.com  ASSI   USB HCs may have improper interrupt configuration with AC...  
71  hig  andrew.grover@intel.com  ASSI   RTL8100BL (8139) do not work on acpi UP without local apic  
111  hig  wli@holomorphy.com  ASSI   hugetlbfs does not align pages  
113  hig  alan@lxorguk.ukuu.org.uk  ASSI   CMD649 or ALI15X3 problem under 2.5.49 and since many pre...  
129  hig  greg@kroah.com  ASSI   usb-storage crashes my pc when i plug in a SIIG Compact F...  
130  hig  green@namesys.com  ASSI   problems mounting root partition with 2.5.48+ kernels  
11  nor  mbligh@aracnet.com  OPEN   Intermezzo Compile Failure  
18  nor  vojtech@suse.cz  OPEN   Synaptics touchpad driver  
46  nor  vojtech@suse.cz  OPEN   ide-scsi causing (Two mice: unwanted double-clicks & erra...  
48  nor  mbligh@aracnet.com  OPEN   APM suspend and PCMCIA not cooperating  
49  nor  mbligh@aracnet.com  OPEN   register_console() called in illegal context  
54  nor  mbligh@aracnet.com  OPEN   100% reproduceable "null TTY for (####) in tty_fasync"  
57  nor  greg@kroah.com  OPEN   usb-storage oops on loading  
58  nor  mbligh@aracnet.com  OPEN   OHCI-1394: sleeping function called from illegal context ...  
69  nor  mbligh@aracnet.com  OPEN   Framebuffer bug  
72  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolls at the wrong times/places  
79  nor  khoa@us.ibm.com  OPEN   Framebuffer scrolling problem  
94  nor  mbligh@aracnet.com  OPEN   file remain locked after sapdb process exist.  
104  nor  khoa@us.ibm.com  OPEN   MIPS fails to build: asm/thread_info.h doesn't exist  
110  nor  khoa@us.ibm.com  OPEN   Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UN...  
115  nor  mbligh@aracnet.com  OPEN   Kernel modules won't load  
117  nor  mbligh@aracnet.com  OPEN   build failure: arch/ppc/kernel/process.c  
122  nor  mbligh@aracnet.com  OPEN   emu10k1 OSS troubles  
126  nor  vojtech@suse.cz  OPEN   bzImage build failure on input devices support as module  
134  nor  mbligh@aracnet.com  OPEN   2.5.50 breaks pcmcia cards  
135  nor  mbligh@aracnet.com  OPEN   SB16/Alsa doesn't work  
138  nor  khoa@us.ibm.com  OPEN   Build error: drivers/video/sis/sis_main.h:299: parse erro...  
143  nor  alan@lxorguk.ukuu.org.uk  OPEN   unable to read cd audio from atapi cdrom/cdrw/dvd device,...  
144  nor  mbligh@aracnet.com  OPEN   error return not checked in register_disk (fs/partitions/...  
145  nor  mbligh@aracnet.com  OPEN   ALSA: SB-AWE ISA detection fails  
149  nor  vojtech@suse.cz  OPEN   Laptop with touchpad and "pointer". Pointer never works  
150  nor  greg@kroah.com  OPEN   [PNP][2.5] IDE Detection problems (wrong IRQ and wrong ID...  
153  nor  mbligh@aracnet.com  OPEN   compile failure on drivers/char/riscom8.c  
154  nor  mbligh@aracnet.com  OPEN   compile failure on drivers/char/esp.c  
155  nor  mbligh@aracnet.com  OPEN   compile failure on drivers/char/specialix.c  
158  nor  mbligh@aracnet.com  OPEN   depmod should be in README  
159  nor  mbligh@aracnet.com  OPEN   compile failure on drivers/isdn/i4l/isdn_net_lib.c  
160  nor  jgarzik@pobox.com  OPEN   With 2 different nic on one system, dhcp configuration fails  
161  nor  mbligh@aracnet.com  OPEN   VESAfb in 2.5 somehow influences X resolution.  
162  nor  khoa@us.ibm.com  OPEN   compile failure on drivers/media/video/bttv-cards.c  
163  nor  mbligh@aracnet.com  OPEN   Impossible to setup MTRR registers  
164  nor  vojtech@suse.cz  OPEN   Linking Failure: drivers/built-in.o  
167  nor  khoa@us.ibm.com  OPEN   compile failure on drivers/media/video/zr36120.c  
168  nor  khoa@us.ibm.com  OPEN   compile failure on drivers/media/video/saa7185.c  
169  nor  khoa@us.ibm.com  OPEN   compile failure on drivers/media/video/bt819.c  
171  nor  vojtech@suse.cz  OPEN   2.5.51 at kb driver leaves kb ib state that prevents (sof...  
172  nor  mbligh@aracnet.com  OPEN   tdfxfb.c can't be compiled  
174  nor  khoa@us.ibm.com  OPEN   link failure in function dvb_generic_ioctl: undefined ref...  
179  nor  mbligh@aracnet.com  OPEN   boot from 21 sec/track floppy  
181  nor  greg@kroah.com  OPEN   Kernel oops when connecting USB digital camera  
182  nor  mbligh@aracnet.com  OPEN   compile fails because of multiple undefined references in...  
5  nor  mbligh@aracnet.com  ASSI   64GB highmem BUG()  
7  nor  willy@debian.org  ASSI   file lock accounting broken  
9  nor  dbrownell@users.sourceforge...  ASSI   Ehci do not leave system in a sensible state for bios on ...  
15  nor  alan@lxorguk.ukuu.org.uk  ASSI   No dma on first hard drive  
16  nor  willy@debian.org  ASSI   reproduceable oops in lock_get_status  
36  nor  andmike@us.ibm.com  ASSI   Long tape rewind causes abort on aic7xxx  
37  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE problems on old pre-PCI HW  
39  nor  alan@lxorguk.ukuu.org.uk  ASSI   undefined reference to `boot_gdt_table'  
43  nor  jgarzik@pobox.com  ASSI   e100 drivers crashes on non cache-coherent platforms  
51  nor  paul@laufernet.com  ASSI   isapnp does not register devices in /proc/isapnp  
52  nor  andmike@us.ibm.com  ASSI   aic7xxx driver fails to boot on netfinity 7000  
53  nor  alan@lxorguk.ukuu.org.uk  ASSI   IDE cd-rom I/O error  
63  nor  wli@holomorphy.com  ASSI   compile error with CONFIG_HUGETLB_PAGE yes  
100  nor  johnstul@us.ibm.com  ASSI   LTP - gettimeofday02 fails (time is going backwards)  
105  nor  johnstul@us.ibm.com  ASSI   gettimeofday cripples system running with notsc  
106  nor  mochel@osdl.org  ASSI   sysfs hierarchy can begin to disintegrate  
119  nor  andrew.grover@intel.com  ASSI   2.5.49 - Dell Latitude weirdness at shutdown  
131  nor  alan@lxorguk.ukuu.org.uk  ASSI   "hda: lost interrupt"; "hda: dma_intr: bad DMA status" on...  
132  nor  acme@conectiva.com.br  ASSI   windows ip check ARP packet replied by kernel when proxy_...  
136  nor  akpm@digeo.com  ASSI   FSID returned from statvfs always 0  
140  nor  andmike@us.ibm.com  ASSI   isp1020 driver reports error  
151  nor  jejb@hansenpartnership.com  ASSI   compile failure on drivers/block/ps2esdi.c  
156  nor  alan@lxorguk.ukuu.org.uk  ASSI   compile failure on drivers/ide/pci/nvidia.c  
165  nor  jgarzik@pobox.com  ASSI   Kernel crashes after stop network and remove e100.  
166  nor  jgarzik@pobox.com  ASSI   e100 spits out strange message during startup.  
142  low  mbligh@aracnet.com  OPEN   problem with ver_linux script and procps version  
8  low  alan@lxorguk.ukuu.org.uk  ASSI   i2o_scsi does not handle reset properly  
28  low  jgarzik@pobox.com  ASSI   Compile time warnings from starfire driver (with PAE enab...  
29  low  akpm@digeo.com  ASSI   Debug: sleeping function called from illegal context at m...  
83  low  zippel@linux-m68k.org  ASSI   Wish: ability to quickly cycle through (NEW) config options  
146  low  akpm@digeo.com  ASSI   Assertion failure in do_get_write_access() at fs/jbd/tra...  
170  low  akpm@digeo.com  ASSI   poisoned oops in dump_orphan_list  

