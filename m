Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbTDCPkZ>; Thu, 3 Apr 2003 10:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbTDCPkZ>; Thu, 3 Apr 2003 10:40:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:2770 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261223AbTDCPkY>;
	Thu, 3 Apr 2003 10:40:24 -0500
Message-ID: <3E8C578E.8000202@us.ibm.com>
Date: Thu, 03 Apr 2003 10:47:26 -0500
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

These bugs have been sitting in RESOLVED state for more than two weeks,
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

230  Other      Configur   zippel@linux-m68k.org
diffsrv URL changed

300  Alternat   mjb        mbligh@aracnet.com
Oops in 2.5.59-mjb1

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

404  File Sys   ext3       akpm@digeo.com
turning off htree causes fsck to complain

