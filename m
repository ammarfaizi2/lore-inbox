Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbRAXWRs>; Wed, 24 Jan 2001 17:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132984AbRAXWRi>; Wed, 24 Jan 2001 17:17:38 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:56621 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S132938AbRAXWR3>;
	Wed, 24 Jan 2001 17:17:29 -0500
Date: Wed, 24 Jan 2001 23:20:21 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre6aa1 USB - Why do I get these?
Message-ID: <Pine.LNX.4.30.0101242317170.15509-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously unseen. What could be the cause of these messages?
(Abit BH6 (Intel BX), Logitech Mouseman+ USB)

Jan 24 21:39:15 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 21:39:16 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 21:44:22 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 21:44:24 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 21:48:53 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 21:48:55 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 21:51:06 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 21:51:06 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 21:51:38 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 21:51:38 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 22:07:45 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 22:07:47 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 22:10:24 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 22:10:25 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 22:11:32 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 22:11:33 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 22:11:57 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 22:11:59 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 22:13:50 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 22:13:52 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 23:13:48 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 23:13:50 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters
Jan 24 23:16:35 iq kernel: usb.c: bw_alloc reduced by 118 to 0 for 0
requesters
Jan 24 23:16:37 iq kernel: usb.c: bw_alloc increased by 118 to 118 for 1
requesters

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
