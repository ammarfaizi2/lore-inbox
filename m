Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbRHPWuQ>; Thu, 16 Aug 2001 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbRHPWuG>; Thu, 16 Aug 2001 18:50:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268963AbRHPWuA>;
	Thu, 16 Aug 2001 18:50:00 -0400
Date: Thu, 16 Aug 2001 15:48:58 -0700 (PDT)
Message-Id: <20010816.154858.63131116.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: tpepper@vato.org, f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15XVp6-0006EW-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15XVp6-0006EW-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 16 Aug 2001 23:41:07 +0100 (BST)

   > The args and semantics of min/max changed to take
   > a type first argument, the problem with this ntfs file is that it
   > fails to include linux/kernel.h
   
   Thank you for your detailed discussion of this in advance on the kernel
   list, your careful consideration of the 2.2 compatibility work horrors you
   introduced and the thoughtful way you notified maintainers.

Listen:

1) All of this was done at the request of Linus.

2) You were CC:'d on every single email
   that Linus and I had on these changes, and you
   saw every single revision of the patch.

Why are you complaining now, please speak up earlier next time when
you have a grip.  This is why you were CC:'d on the emails.

I am actually unhappy Linus waited until 2.4.9 final to put those
changes in as I was sure 1 or 2 compile issues would slip through.
I have been sending it over and over throughout the 2.4.9 prepatches.

Later,
David S. Miller
davem@redhat.com
