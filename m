Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbRCBDdR>; Thu, 1 Mar 2001 22:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130198AbRCBDdH>; Thu, 1 Mar 2001 22:33:07 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:4612 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S129449AbRCBDdD>;
	Thu, 1 Mar 2001 22:33:03 -0500
Date: Thu, 1 Mar 2001 22:32:25 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac7 doesn't boot on K6-2
Message-ID: <20010301223225.A70@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.2 worked OK, but I needed loopback also, so I tried 2.4.2-ac7.
I get the "uncompressing... Booting" line, and it hangs there
(I let it sit for 30s to be sure).

System: AMD K6-2/266, ATI Mach64, oldBusLogic SCSI card, almost
evreything compiled as modules.

I will try ac-8 once it shows up on the mirrors.

-Eric
