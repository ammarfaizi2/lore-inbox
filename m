Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbRHPXDh>; Thu, 16 Aug 2001 19:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHPXD1>; Thu, 16 Aug 2001 19:03:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18304 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268936AbRHPXDO>;
	Thu, 16 Aug 2001 19:03:14 -0400
Date: Thu, 16 Aug 2001 16:02:08 -0700 (PDT)
Message-Id: <20010816.160208.55508845.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: tpepper@vato.org, f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15XW3E-0006GP-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15XW3E-0006GP-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 16 Aug 2001 23:55:44 +0100 (BST)

   > 2) You were CC:'d on every single email
   >    that Linus and I had on these changes, and you
   >    saw every single revision of the patch.
   
   Yep. And at the time I asked you to send it to the maintainers and the like.

When you were shown the patch your sentiments were:

1) Some of that stuff is against old drivers, I have newer
   ones in -ac so no biggie.
2) The ixj instances look like real bugs, and that you'd
   have a closer look.
3) If there are any merge issues in your -ac tree, no big
   deal because they'd show up as obvious compile errors.
4) Otherwise, it looked just fine to you.

I don't recall you saying anything about "make sure to tell the
maintainers" But, on the other hand, I can't prove that you didn't (I
don't keep detailed mail logs anymore except for what I send out
myself), so if you did I apologize.

Later,
David S. Miller
davem@redhat.com
