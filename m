Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265485AbTFMSSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTFMSQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:16:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56249 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265475AbTFMSNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:13:43 -0400
Message-ID: <3EEA1716.9000903@us.ibm.com>
Date: Fri, 13 Jun 2003 14:25:26 -0400
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
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

345  Drivers    SCSI       mikenc@us.ibm.com
compile failure in drivers/scsi/inia100.c

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

412  Drivers    USB        dbrownell@users.sourceforge.net
[EHCI] report of first interrupt transfer is delayed

418  Drivers    USB        greg@kroah.com
Bad use of GFP_DMA

663  Drivers    Sound      bugme-janitors@lists.osdl.org
"make modules" causes an error in mwavedd.h.

691  Platform   x86-64     ak@suse.de
change_pageattr corrupts memory (breaks AGP)

