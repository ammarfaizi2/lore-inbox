Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbRHPXms>; Thu, 16 Aug 2001 19:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269155AbRHPXmi>; Thu, 16 Aug 2001 19:42:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32896 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269154AbRHPXm2>;
	Thu, 16 Aug 2001 19:42:28 -0400
Date: Thu, 16 Aug 2001 16:40:27 -0700 (PDT)
Message-Id: <20010816.164027.85686335.davem@redhat.com>
To: aia21@cam.ac.uk
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk>
In-Reply-To: <20010816230719Z16545-1231+1256@humbolt.nl.linux.org>
	<E15XWKz-0006J6-00@the-village.bc.nu>
	<5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Altaparmakov <aia21@cam.ac.uk>
   Date: Fri, 17 Aug 2001 00:35:02 +0100

   Otherwise I would submit a patch to switch NTFS. I don't like this 3 arg 
   construct...

Linus will reject every such patch, and I have grepping scripts that
will detect crap like this entering the tree in case he misses
something.

Later,
David S. Miller
davem@redhat.com
