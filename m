Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269268AbTGOStp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbTGOStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:49:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2016 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269268AbTGOSs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:48:58 -0400
Message-ID: <3F144F71.4050106@us.ibm.com>
Date: Tue, 15 Jul 2003 15:01:05 -0400
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

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

590  File Sys   VFS        zwane@holomorphy.com
Cannot boot: get VFS cannot mount root on XFS and EXT2 partitions

719  Process    Schedule   rml@tech9.net
[perf][kernbench] lower performance with HT enabled on low loads

796  File Sys   JFS        shaggy@austin.ibm.com
Kernel Oops with nfsd.

807  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
gprs pcmcia card not works in linux

