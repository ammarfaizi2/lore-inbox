Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTBUBA2>; Thu, 20 Feb 2003 20:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTBUBA2>; Thu, 20 Feb 2003 20:00:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7166 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267089AbTBUBA0>;
	Thu, 20 Feb 2003 20:00:26 -0500
Date: Thu, 20 Feb 2003 17:01:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Stacy Woods <spwoods@us.ibm.com>
Subject: Bugs sitting in RESOLVED state
Message-ID: <273770000.1045789304@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in RESOLVED state for > 1 week, ie
they have fixes, but aren't back in the mainline tree (when they
should move to CLOSED state). If the fixes are back in mainline
already, could the owner close them out? Otherwise, perhaps we
can get those fixes back in?

http://bugme.osdl.org

  13  Platform   UML        jdike@karaya.com
user-mode-linux (ARCH=um) compile broken in 2.5.47

  14  Drivers    Video      davej@codemonkey.org.uk
No dri : unsupported Via chipset (device id: 3189)

  22  File       Sys        alan@lxorguk.ukuu.org.uk
Other /lib/modules/2.5.47-ac3-rous1/kernel/fs/ntfs/ntfs.o: unre...

  24  File       Sys        khoa@us.ibm.com
NFS statfs returns incorrect number fo blocks

  45  IO/Stora   Block      mbligh@aracnet.com
La blk_rq_map_sg() returns incorrect number of segments

  46  Drivers    Input      vojtech@suse.cz
De ide-scsi causing (Two mice: unwanted double-clicks & erra...

  47  Alternat   ac         khoa@us.ibm.com
nfs broken in UP? unresolved symbol page_states__per_cpu

  65  IO/Stora   IDE        alan@lxorguk.ukuu.org.uk
IDE broken on laptop when docked

  73  Platform   PA-RISC    willy@debian.org
Kernel compile fails in arch/parisc/kernel/.irq.o.d

  77  Other      Other      mbligh@aracnet.com
ieee1394 sbp2 module panics on load

  85  Drivers    Network    jgarzik@pobox.com
ham radio stuff still using cli etc

 100  Timers     gettimeo   johnstul@us.ibm.com
LTP - gettimeofday02 fails (time is going backwards)

 107  Other      Modules    mbligh@aracnet.com
Current Linus Tree, Modules just don't work, they aren't ...

 134  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
2.5.50 breaks pcmcia cards

 137  Platform   i386       mbligh@aracnet.com
Build error: drivers/pci/quirks.c:354: sis_apic_bug' unde...

 165  Drivers    Network    jgarzik@pobox.com
Kernel crashes after stop network and remove e100.

 172  Drivers    Console    jsimmons@infradead.org
tdfxfb.c can't be compiled

 196  Drivers    Video      bugme-janitors@lists.osdl.org
compile failure on drivers/media/video/stradis.c

 206  Drivers    Console    jsimmons@infradead.org
broken colors on framebuffer console

 230  Other      Configur   zippel@linux-m68k.org
diffsrv URL changed

 242  Drivers    SCSI       hannal@us.ibm.com
buffer out of bounds in aha1542.c from Andy Chou <acc@cs....

 245  Drivers    SCSI       hannal@us.ibm.com
Possible out of bound error in sym53c416.c from Andy Chou...

 256  Drivers    Network    jgarzik@pobox.com
3c509.c wants updating to new pnp model

 259  Drivers    IEEE1394   bcollins@debian.org
compile failure in drivers/ieee1394/pcilynx.c

 272  Networki   Other      acme@conectiva.com.br
Dangerous status when start network (driver is e100).

 282  Drivers    Other      hannal@us.ibm.com
tty drivers need to set .owner field

 292  Drivers    Console    jsimmons@infradead.org
no cursor in console

 306  Power      Ma         andrew.grover@intel.com
ACPI Compile failure with ACPI

 309  Drivers    Input      vojtech@suse.cz
De misplaced/extra semicolon drivers/input/joydev.c:343

 311  Drivers    Network    jgarzik@pobox.com
misplaced/extra semicolon drivers/net/amd8111e.c

 312  Drivers    Network    jgarzik@pobox.com
misplaced/extra semicolon drivers/net/tokenring/smctr.c

 323  Drivers    Network    jgarzik@pobox.com
double logical operator drivers/net/fc/iph5526.c

 330  Drivers    SCSI       andmike@us.ibm.com
compile error ( imm.c )

 348  Drivers    SCSI       andmike@us.ibm.com
2.5.60 broke compile of aha152x


