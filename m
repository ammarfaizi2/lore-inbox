Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268168AbTCFTSV>; Thu, 6 Mar 2003 14:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268272AbTCFTSV>; Thu, 6 Mar 2003 14:18:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:8627 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268168AbTCFTSU>;
	Thu, 6 Mar 2003 14:18:20 -0500
Message-ID: <3E67A073.7080004@us.ibm.com>
Date: Thu, 06 Mar 2003 14:24:35 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs sitting in the RESOLVED state for more than 2 weeks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in RESOLVED state for more than 2 weeks, ie
they have fixes, but aren't back in the mainline tree (when they
should move to CLOSED state). If the fixes are back in mainline
already, could the owner close them out? Otherwise, perhaps we
can get those fixes back in?

The Bugzilla interface has been changed so that bugs can now go from the NEW
or ASSIGNED state directly to the CLOSED state.

Kernel Bug Tracker:   http://bugme.osdl.org

  9  Drivers    USB        dbrownell@users.sourceforge.net
EHCI not properly shut down on reboot, kills usb keyboard in bios/bootloader

  13  Platform   UML        jdike@karaya.com
user-mode-linux (ARCH=um) compile broken in 2.5.47

  22  File Sys   Other      alan@lxorguk.ukuu.org.uk
/lib/modules/2.5.47-ac3-rous1/kernel/fs/ntfs/ntfs.o: unresolved symbol 
page_stat

  24  File Sys   NFS        khoa@us.ibm.com
statfs returns incorrect  number fo blocks

  47  Alternat   ac         khoa@us.ibm.com
nfs broken in UP? unresolved symbol page_states__per_cpu

  85  Drivers    Network    jgarzik@pobox.com
ham radio stuff still using cli etc

206  Drivers    Console/   jsimmons@infradead.org
broken colors on framebuffer console

230  Other      Configur   zippel@linux-m68k.org
diffsrv URL changed

242  Drivers    SCSI       hannal@us.ibm.com
buffer out of bounds in aha1542.c from Andy Chou <acc@cs.stanford.edu>

245  Drivers    SCSI       hannal@us.ibm.com
Possible out of bound error in sym53c416.c from Andy Chou 
<acc@cs.stanford.edu>

364  Other      Other      mbligh@aracnet.com
oops in render_sigset_t with 2.5.61 running SDET

366  Drivers    IEEE1394   bcollins@debian.org
ieee1394 fails to compile  linux/drivers/ieee1394/dma.c

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

