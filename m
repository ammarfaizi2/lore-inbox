Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271471AbTGQOnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271472AbTGQOnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:43:32 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:236 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S271471AbTGQOnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:43:18 -0400
Date: Thu, 17 Jul 2003 07:58:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rory Browne <robro@frink.nuigalway.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK Licence: Protocols and Research
Message-ID: <20030717145802.GC24697@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rory Browne <robro@frink.nuigalway.ie>,
	linux-kernel@vger.kernel.org
References: <20030717120505.GA22304@zion.nuigalway.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717120505.GA22304@zion.nuigalway.ie>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With apologies to the list for the off topic post (I'm really trying to
not annoy you guys but some stuff we can't let slide due to legalities).

On Thu, Jul 17, 2003 at 01:05:05PM +0100, Rory Browne wrote:
> Would the conduction of research(and publication of results of same) on 
> the bitkeeper formats/protocols, preclude users from using the Free version 
> of Bitkeeper, for the research project?

Yes, for the research project and/or anything else.

> Would the carrying out of such research using the free version of
> Bitkeeper, prevent them from developing a product which contains
> substantially similar capabilities of the BitKeeper Software in the
> Future, assuming that all copies of Bitkeeper were destroyed before the
> development started?

Yes.

> Would previous activity in the area of developing a product which
> contains substantially similary features to Bitkeeper preclude users from
> using the Free Bitkeeper software?

Yes.

Each question above can be restated as "Would it be OK if we used BK
in violation of its license?".  The answer is no and if you did that we
would be forced to come after you, if we don't and some large company did
the same thing we would have a much tougher time enforcing the license.
Trademarks and licenses tend to lose their value if you don't enforce
them.

Your questions indicate one of two things: you either have a burning
desire to work on BK itself or a burning desire to copy BK.  If it's
the former, that's easy, send us a resume and if you are a good engineer
we'll hire you, we need good engineers with a solid understanding of file
systems, distributed systems, graphs and sets, and/or human interfaces.

If you are trying to copy BK, give it up.  We'll simply follow in the
footsteps of every other company faced with this sort of thing and change
the protocol every 6 months.  Since you would be chasing us you can never
catch up.  If you managed to stay close then we'd put digital signatures
into the protocol to prevent your clone from interoperating with BK.

Instead of trying to copy our work in violation of our license, you'd be
far better served by doing some new work.  If you like SCM then either
work here, work on some other SCM unrelated to BK, or expect a costly
discussion with a lawyer.  I realize this is an unpopular position but
that's tough, it's our code and our license and you obey the rules
or suffer the consequences.  The license is a contract and it's an
enforceable contract, we have gone up against a company who spends more
on lawyers in a week than our annual gross revenues and successfully
enforced it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
