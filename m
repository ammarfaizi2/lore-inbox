Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbTAKARF>; Fri, 10 Jan 2003 19:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbTAKARE>; Fri, 10 Jan 2003 19:17:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16083 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266712AbTAKAPR>; Fri, 10 Jan 2003 19:15:17 -0500
Date: Fri, 10 Jan 2003 16:16:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs that are resolved but not closed in Bugzilla
Message-ID: <306150000.1042244212@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 31 bugs in RESOLVED state in Bugzilla, but not CLOSED.
Either they should be closed, or there's a patch available that's not pushed.

If the patch is merged into Linus's tree, please could you close them out,
or send me email and I will?

If it's floating around somewhere, maybe this is a gentle reminder to push
the patch ..... ;-)

Thanks,

Martin.

PS. Yeah, I own some of them. I'll poke myself in the eye too.

ID Sev Owner State Result Summary
1 nor mbligh@aracnet.com RESO PATC oops when using ide-cd with 2.5.45 and cdrecord
13 blo mbligh@aracnet.com RESO CODE user-mode-linux (ARCH=um) compile broken in 2.5.47
22 nor alan@lxorguk.ukuu.org.uk RESO CODE /lib/modules/2.5.47-ac3-rous1/kernel/fs/ntfs/ntfs.o: unre...
24 nor khoa@us.ibm.com RESO PATC statfs returns incorrect number fo blocks
28 low jgarzik@pobox.com RESO CODE Compile time warnings from starfire driver (with PAE enab...
45 nor mbligh@aracnet.com RESO PATC blk_rq_map_sg() returns incorrect number of segments
47 nor khoa@us.ibm.com RESO CODE nfs broken in UP? unresolved symbol page_states__per_cpu
57 nor greg@kroah.com RESO PATC usb-storage oops on loading
65 nor alan@lxorguk.ukuu.org.uk RESO PATC IDE broken on laptop when docked
67 blo zaitcev@yahoo.com RESO PATC Kernel compile fails -- LDFLAGS seem to be wrong
73 blo willy@debian.org RESO PATC Kernel compile fails in arch/parisc/kernel/.irq.o.d
74 blo zaitcev@yahoo.com RESO PATC Kernel Compile fails in fs/.binfmt_elf.o.d
77 hig mbligh@aracnet.com RESO PATC ieee1394 sbp2 module panics on load
85 nor jgarzik@pobox.com RESO CODE ham radio stuff still using cli etc
107 hig mbligh@aracnet.com RESO CODE Current Linus Tree, Modules just don't work, they aren't ...
112 hig mbligh@aracnet.com RESO PATC Ximian Gnome and Evolution hang on 2.5, maintainers shoul...
124 nor greg@kroah.com RESO PATC kernel build fail
128 nor mbligh@aracnet.com RESO CODE 2.5.50 CONFIG_ACPI_SLEEP fails to build without
137 nor mbligh@aracnet.com RESO PATC Build error: drivers/pci/quirks.c:354: sis_apic_bug' unde...
144 nor mbligh@aracnet.com RESO CODE error return not checked in register_disk (fs/partitions/...
163 nor mbligh@aracnet.com RESO CODE Impossible to setup MTRR registers
172 nor jsimmons@infradead.org RESO CODE tdfxfb.c can't be compiled
180 hig davej@codemonkey.org.uk RESO CODE Broken agpgart on i815 (maybe other ICH too)
186 nor mbligh@aracnet.com RESO CODE kernel not honoring init= bootparm
187 low hannal@us.ibm.com RESO CODE Need more clear documentation for bug tracking processes
194 blo jgarzik@pobox.com RESO CODE compilation fails drivers/net/defxx.c
206 nor jsimmons@infradead.org RESO CODE broken colors on framebuffer console
225 nor khoa@us.ibm.com RESO CODE Specifying DMA channel for parport causes oops in dma_all...
226 nor bugme-janitors@lists.osdl.org RESO CODE compile failure in fs/romfs/inode.c
230 nor zippel@linux-m68k.org RESO PATC diffsrv URL changed
251 low trond.myklebust@fys.uio.no RESO PATC Possible off by one error in inode.c from Stanford Checker


