Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbQKBIQg>; Thu, 2 Nov 2000 03:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132144AbQKBIQ1>; Thu, 2 Nov 2000 03:16:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63890 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130309AbQKBIQM>;
	Thu, 2 Nov 2000 03:16:12 -0500
Date: Thu, 2 Nov 2000 00:01:17 -0800
Message-Id: <200011020801.AAA23866@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jgarzik@mandrakesoft.com
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, dhinds@valinux.com,
        randy.dunlap@intel.com, mj@ucw.cz
In-Reply-To: <3A012059.D328F190@mandrakesoft.com> (message from Jeff Garzik on
	Thu, 02 Nov 2000 03:05:45 -0500)
Subject: Re: PATCH 2.4.0.10: Update hotplug
In-Reply-To: <3A012059.D328F190@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 02 Nov 2000 03:05:45 -0500
   From: Jeff Garzik <jgarzik@mandrakesoft.com>

   DaveM - netdevice.h seems like the best place to include businfo.h.
   Since it doesn't include anything but linux/types.h, that should
   eliminate any worry about a nightmare of nested includes...

Ok.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
