Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276357AbTHSQaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275272AbTHSQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:19:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272324AbTHSQQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:16:34 -0400
Message-ID: <3F4227E9.9000900@us.ibm.com>
Date: Tue, 19 Aug 2003 09:36:41 -0400
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
can get those fixes back in?

Kernel Bug Tracker: http://bugme.osdl.org

  24  File Sys   NFS        khoa@us.ibm.com
statfs returns incorrect  number fo blocks

  85  Drivers    Network    jgarzik@pobox.com
ham radio stuff still using cli etc

150  Drivers    PNP        ambx1@neo.rr.com
[PNP][2.5] IDE Detection problems (wrong IRQ and wrong IDE device number)

206  Drivers    Console/   jsimmons@infradead.org
broken colors on framebuffer console

257  Drivers    Network    jgarzik@pobox.com
Broadcom b44 driver won't work

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

493  Drivers    USB        mdharm-usb@one-eyed-alien.net
Support for Sony DSC-P72 not available

590  File Sys   VFS        zwane@holomorphy.com
Cannot boot: get VFS cannot mount root on XFS and EXT2 partitions

719  Process    Schedule   rml@tech9.net
[perf][kernbench] lower performance with HT enabled on low loads

737  Platform   SPARC64    bugme-janitors@lists.osdl.org
compiler version requirements mismatch/uncertainty for sparc

796  File Sys   JFS        shaggy@austin.ibm.com
Kernel Oops with nfsd.

807  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
gprs pcmcia card not works in linux

817  Drivers    Network    jgarzik@pobox.com
Receiving "Bus master arbitration failure, status ffff" error

820  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA emu10k doesn't load in 2.5.7[12]

907  File Sys   NFS        neilb@cse.unsw.edu.au
Kernel oops with nfs3svc_decode_symlinkargs

911  Drivers    PCI        ak@suse.de
[x86_64] Badness in pci_find_subsys at drivers/pci/search.c:132

915 Drivers USB greg@kroah.com
Slab corruption

927 Drivers Video(AG davej@codemonkey.org.uk
nvidia_agp module has unresolved symbols (includes fix)

954 Platform PPC-32 bugme-janitors@lists.osdl.org
link failure for arch/ppc/mm/built-in.o, function mem_pieces_find




