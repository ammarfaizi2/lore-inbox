Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310354AbSCGOnR>; Thu, 7 Mar 2002 09:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310170AbSCGOnI>; Thu, 7 Mar 2002 09:43:08 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:21897 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310354AbSCGOm7>; Thu, 7 Mar 2002 09:42:59 -0500
Date: Thu, 7 Mar 2002 06:42:55 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, fischer@norbit.de
Subject: Patch?: linux-2.5.6-pre3/drivers/scsi patches for aha152x and aha1740
Message-ID: <20020307064255.A1655@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have not tested these drivers in any way (in fact, I cannot
get linux-2.5.6-pre3 to boot right now), but I thought I would post
this preliminary patch in case anyone is interested.  This patch
gets the aha152x and aha1740 scsi drivers in linux-2.5.6-pre3 to
compile.  It requires the changes to scsi.[ch] and hosts.h that
I posted a few hours ago with the pci2220i, advansys and BusLogic
patches.  Anyhow, I thought I would post these patches, in case anyone
wants to comment on them or try them.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
