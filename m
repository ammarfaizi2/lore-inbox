Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTBHGGO>; Sat, 8 Feb 2003 01:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbTBHGGO>; Sat, 8 Feb 2003 01:06:14 -0500
Received: from dp.samba.org ([66.70.73.150]:9122 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266968AbTBHGGN>;
	Sat, 8 Feb 2003 01:06:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support. 
In-reply-to: Your message of "Fri, 07 Feb 2003 10:05:40 -0000."
             <20030207100540.B23442@flint.arm.linux.org.uk> 
Date: Sat, 08 Feb 2003 15:32:39 +1100
Message-Id: <20030208061554.E75892C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030207100540.B23442@flint.arm.linux.org.uk> you write:
> On Fri, Feb 07, 2003 at 07:26:50PM +1100, Rusty Russell wrote:
> > Actually, I must be really confused.  I thought ARM was already
> > complete.
> > 
> > Anyway, here's a version which simply does what the usermode one did,
> > if you decide to take the "fix it later" approach.
> 
> Rusty, as I said, I already have a patch for this approach.  Its the
> second approach that I'd prefer to get working.

Sure, but you complained that I hadn't made life easier for the arch
maintainers.  I'm sorry if you feel this way, but I felt that the
least I could do, at the first complaint I was aware of, was to
provide you with a solution.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
