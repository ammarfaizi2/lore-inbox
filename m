Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbRAGMSp>; Sun, 7 Jan 2001 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131146AbRAGMSg>; Sun, 7 Jan 2001 07:18:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28034 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131114AbRAGMST>;
	Sun, 7 Jan 2001 07:18:19 -0500
Date: Sun, 7 Jan 2001 04:01:04 -0800
Message-Id: <200101071201.EAA01790@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: cw@f00f.org
CC: david@linux.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <20010108011308.A2575@metastasis.f00f.org> (message from Chris
	Wedgwood on Mon, 8 Jan 2001 01:13:08 +1300)
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org> <20010108011308.A2575@metastasis.f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Mon, 8 Jan 2001 01:13:08 +1300
   From: Chris Wedgwood <cw@f00f.org>

   OK, I'm a liar -- bind does handle this. Cool.

Standard BSD allows it, what do you expect :-)

   This is good news, because it means there is a precedent for multiple
   addresses on a single interface so we can kill the <ifname>:<n>
   syntax in favor of the above which is cleaner of more accurately
   represents what is happening.

If this is really true, 2.5.x is an appropriate time to make
this, no sooner.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
