Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbTISPJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 11:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbTISPJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 11:09:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20213 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261596AbTISPJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 11:09:20 -0400
Message-ID: <3F6B1B0D.7080103@us.ibm.com>
Date: Fri, 19 Sep 2003 11:04:45 -0400
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
then the bug needs to be moved back into the OPEN or ASSIGNED state.

Kernel Bug Tracker: http://bugme.osdl.org


  24  File Sys   NFS        khoa@us.ibm.com
statfs returns incorrect  number fo blocks

  85  Drivers    Network    jgarzik@pobox.com
ham radio stuff still using cli etc

206  Drivers    Console/   jsimmons@infradead.org
broken colors on framebuffer console

322  Drivers    Other      jeffpc@optonline.net
double logical operator drivers/char/sx.c

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

493  Drivers    USB        mdharm-usb@one-eyed-alien.net
Support for Sony DSC-P72 not available

624  Process    Schedule   ricklind@us.ibm.com
[perf][specjbb] Hyperthreading causing excessive thread starvation in 
benchmark

719  Process    Schedule   rml@tech9.net
[perf][kernbench] lower performance with HT enabled on low loads

737  Platform   SPARC64    bugme-janitors@lists.osdl.org
compiler version requirements mismatch/uncertainty for sparc

753  Drivers    ISDN       bugme-janitors@lists.osdl.org
hisax needs unresolved symbol kstat__per_cpu

796  File Sys   JFS        shaggy@austin.ibm.com
Kernel Oops with nfsd.

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

927  Drivers    Video(AG   davej@codemonkey.org.uk
nvidia_agp module has unresolved symbols (includes fix)

928  Other      Configur   bugme-janitors@lists.osdl.org
cryptoloop has unresolved symbols (includes fix)

954  Platform   PPC-32     bugme-janitors@lists.osdl.org
link failure for arch/ppc/mm/built-in.o, function mem_pieces_find

993  Other      Other      jeffpc@optonline.net
Documentation/Changes still reads 2.5

1053  Drivers    USB        greg@kroah.com
Creative ov511 USB camera not working in 2.6

1057  Alternat   mm         akpm@digeo.com
oops performing AIO write with O_DIRECT to block device

1080  Drivers    Sound      francesco@unipg.it
alsa driver snd-powermac doesn't work with tumbler on iBook2

1108  Drivers    Serial     rmk@arm.linux.org.uk
dz.c compile error: Uses BH functions which have been removed from 
include/linux

