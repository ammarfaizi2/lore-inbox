Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHQGM2>; Fri, 17 Aug 2001 02:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRHQGMR>; Fri, 17 Aug 2001 02:12:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8834 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269726AbRHQGMB>;
	Fri, 17 Aug 2001 02:12:01 -0400
Date: Thu, 16 Aug 2001 23:12:13 -0700 (PDT)
Message-Id: <20010816.231213.55724359.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108170503.WAA07234@baldur.yggdrasil.com>
In-Reply-To: <200108170503.WAA07234@baldur.yggdrasil.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Thu, 16 Aug 2001 22:03:07 -0700

   	The macro "min(n1,n2)", is a very standard practice in C
   programming.

If min() in it's "very standard practice" form is broken at
the core, breaking it like I have is a fix.

Let this go till Linus returns from Finland in a week or so,
I'm sure he'll be more than happy to state why he wanted
me to do these changes.

Later,
David S. Miller
davem@redhat.com
