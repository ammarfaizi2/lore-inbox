Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbQLNFJi>; Thu, 14 Dec 2000 00:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQLNFJ2>; Thu, 14 Dec 2000 00:09:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129977AbQLNFJO>;
	Thu, 14 Dec 2000 00:09:14 -0500
Date: Wed, 13 Dec 2000 20:22:48 -0800
Message-Id: <200012140422.UAA10340@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: gibbs@scsiguy.com
CC: shirsch@adelphia.net, linux-kernel@vger.kernel.org
In-Reply-To: <200012140356.eBE3u8s42047@aslan.scsiguy.com> (gibbs@scsiguy.com)
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
In-Reply-To: <200012140356.eBE3u8s42047@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 13 Dec 2000 20:56:08 -0700
   From: "Justin T. Gibbs" <gibbs@scsiguy.com>

   None-the-less, it seems to me that spamming the kernel namespace
   with "current" in at least the way that the 2.2 kernels do (does
   this occur in later kernels?) should be corrected.

Justin, "current" is a pointer to the current thread executing on the
current processor under Linux.  It has existed since day one of the
Linux kernel and probably will exist till the end of it's life.

I'm sure the BSD kernel has some similar bogosity :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
