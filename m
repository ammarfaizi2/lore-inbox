Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTJXNRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 09:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJXNRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 09:17:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:51095 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262225AbTJXNRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 09:17:33 -0400
Message-ID: <3F992520.1080008@us.ibm.com>
Date: Fri, 24 Oct 2003 09:12:00 -0400
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bugs sitting in the RESOLVED state for more than 28 days
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in RESOLVED state for more than 28 days,
ie, they have fixes, but aren't back in the mainline tree (when they
should move to CLOSED state). If the fixes are back in mainline
already, could the owner close them out? Otherwise, perhaps we
can get those fixes back in?  If the patch has not fixed the problem
then the bug needs to be moved back into the NEW or ASSIGNED state.

Kernel Bug Tracker: http://bugme.osdl.org

  10  Power Ma   ACPI       len.brown@intel.com
USB HCs may have improper interrupt configuration with ACPI in IOAPIC mode

  85  Drivers    Network    jgarzik@pobox.com
ham radio stuff still using cli etc

206  Drivers    Console/   jsimmons@infradead.org
broken colors on framebuffer console

257  Drivers    Network    jgarzik@pobox.com
Broadcom b44 driver won't work

322  Drivers    Other      jeffpc@optonline.net
double logical operator drivers/char/sx.c

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

493  Drivers    USB        mdharm-usb@one-eyed-alien.net
Support for Sony DSC-P72 not available

600  File Sys   Other      willy@debian.org
File locking memory leak

653  Platform   i386       mbligh@aracnet.com
i386 NUMA does not work on non x440/Summit

678  Power Ma   ACPI       len.brown@intel.com
ACPI VIA KT400, VT6102 interrupt assignment issue

719  Process    Schedule   rml@tech9.net
[perf][kernbench] lower performance with HT enabled on low loads

737  Platform   SPARC64    bugme-janitors@lists.osdl.org
compiler version requirements mismatch/uncertainty for sparc

753  Drivers    ISDN       bugme-janitors@lists.osdl.org
hisax needs unresolved symbol kstat__per_cpu

774  Power Ma   ACPI       len.brown@intel.com
ACPI SCI interrupt storm on Tyan Tiger MB in APIC mode

807  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
gprs pcmcia card not works in linux

817  Drivers    Network    jgarzik@pobox.com
Receiving "Bus master arbitration failure, status ffff" error

820  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA emu10k doesn't load in 2.5.7[12]

858  Timers     Interval   bugme-janitors@lists.osdl.org
itimer resolution and rounding vs posix

907  File Sys   NFS        neilb@cse.unsw.edu.au
Kernel oops with nfs3svc_decode_symlinkargs

911  Drivers    PCI        ak@suse.de
[x86_64] Badness in pci_find_subsys at drivers/pci/search.c:132

923  Drivers    Network    jgarzik@pobox.com
sis900 causes Badness in pci_find_subsys at drivers/pci/search.c:132

928  Other      Configur   bugme-janitors@lists.osdl.org
cryptoloop has unresolved symbols (includes fix)

954  Platform   PPC-32     bugme-janitors@lists.osdl.org
link failure for arch/ppc/mm/built-in.o, function mem_pieces_find

1053  Drivers    USB        greg@kroah.com
Creative ov511 USB camera not working in 2.6

1057  Alternat   mm         akpm@digeo.com
oops performing AIO write with O_DIRECT to block device

1080  Drivers    Sound      francesco@unipg.it
alsa driver snd-powermac doesn't work with tumbler on iBook2

1108  Drivers    Serial     rmk@arm.linux.org.uk
dz.c compile error: Uses BH functions which have been removed from 
include/linux
1161  Alternat   mm         akpm@digeo.com
Hdparm segmentation fault

1227  Drivers    USB        greg@kroah.com
Oops with SynCE and Compaq iPAQ 3600

1234  Other      Configur   zippel@linux-m68k.org
scripts/mkconfigs uses deprecated 'head -1' syntax

1249  File Sys   Other      bugme-janitors@lists.osdl.org
use O_DIRECT open file, when read will hang.


