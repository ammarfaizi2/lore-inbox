Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129502AbRCBVZX>; Fri, 2 Mar 2001 16:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCBVZO>; Fri, 2 Mar 2001 16:25:14 -0500
Received: from ausxc08.us.dell.com ([143.166.99.216]:59332 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S129502AbRCBVZA>; Fri, 2 Mar 2001 16:25:00 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9DFB@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Subject: 2.4 and 2GB swap partition limit
Date: Fri, 2 Mar 2001 15:23:34 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus has spoken, and 2.4.x now requires swap = 2x RAM.
But, the 2GB per swap partition limit still exists, best as we can tell.
So, we sell machines with say 8GB RAM.  We need 16GB swap, but really we
need like an 18GB disk with 8 2GB swap partitions, or ideally 8 disks with a
2GB swap partition on each.  That's ugly.

Is the 2GB per swap partition going to go away any time soon?

Thanks,
Matt


--
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux

