Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315841AbSEMFRy>; Mon, 13 May 2002 01:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315842AbSEMFRx>; Mon, 13 May 2002 01:17:53 -0400
Received: from bitmover.com ([192.132.92.2]:37549 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315841AbSEMFRw>;
	Mon, 13 May 2002 01:17:52 -0400
Date: Sun, 12 May 2002 22:17:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020512221752.A17225@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE> <abn6q9$umv$1@penguin.transmeta.com> <3CDF4AAE.1020605@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:10:06AM -0400, Jeff Garzik wrote:
> (speaking more to the crowd...)
> Changeset comments need to be written as if they stand alone, without 
> any other context -- including the author.  A reader should not need to 
> know that (for examples) James Simmons hacks on fbdev stuff.

100% agreed.

Part of the design of citool was an attempt to guide people towards
doing that.  We encourage people to do the detailed stuff on the file
comments and the logical level comment on the changeset.  Think of file
as the "how" and the changeset as the "what".

The good news is that people do tend to get better once they realize
that other people read this stuff.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
