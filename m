Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQKBU2f>; Thu, 2 Nov 2000 15:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbQKBU2Z>; Thu, 2 Nov 2000 15:28:25 -0500
Received: from ns.caldera.de ([212.34.180.1]:9224 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129379AbQKBU2T>;
	Thu, 2 Nov 2000 15:28:19 -0500
Date: Thu, 2 Nov 2000 21:27:30 +0100
Message-Id: <200011022027.VAA16027@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: ak@suse.de (Andi Kleen)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Riker <Tim@Rikers.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20001102212124.A15054@gruyere.muc.suse.de>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001102212124.A15054@gruyere.muc.suse.de> you wrote:
> You also forgot named structure initializers, but C99 supports them 
> again with a different syntax than gcc [I guess it would have been too easy
> to just use the gcc syntax]

The named initializers syntax in C99 is from plan9, besides beeing probably
older, it is from the C creators and more logic ;)

I think that are enough reasons for the ANSI people to not choose the GCC
syntax.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
