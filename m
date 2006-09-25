Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWIYKDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWIYKDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWIYKDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:03:53 -0400
Received: from dp.samba.org ([66.70.73.150]:14751 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1750926AbWIYKDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:03:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17687.43288.386345.551650@samba.org>
Date: Mon, 25 Sep 2006 20:02:00 +1000
To: linux-kernel@vger.kernel.org
Subject: Re: GPLv3 Position Statement
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Thanks for posting this. It's obviously had a lot of thought go into
it.

I do think there are a few flaws in the arguments however. The biggest
one for me can be summed up in the question "which license better
represents the intention of the GPLv2 in the current world?"

When the GPLv2 was drafted it wasn't a legal document in a vacuum. It
came with a preamble that stated its intentions, and it came with
someone who toured the world explaining the intentions and
motivations. There were even plenty of repeat performances for anyone
who wanted to attend :-)

I think the GPLv3 does a better job of expressing legally those
intentions than GPLv2 did. In particular this part of the v2 preamble:

  "For example, if you distribute copies of such a program, whether
   gratis or for a fee, you must give the recipients all the rights
   that you have."

I think that recent developments (such as TiVo v2) have shown that
companies have found ways to give recipients less rights then they
have themselves. 

So I think the parts of the position statement that talk about the
importance of the 'development contract as expressed/represented by
GPLv2' and the implication that this contract would be violated by the
current GPLv3 draft are not accurate. That development contract came
with a clear explanation (or at least it seems clear to me).

Similarly, the position statement states:

  "This in turn is brought about by a peculiar freedom enshrined in the
  developer contract as represented by GPLv2, namely the freedom from
  binding the end use of the project."

but I think this particular 'freedom' comes more from the development
conventions of the Linux kernel community than from the GPLv2. I don't
see anything in the GPLv2 that actually tried to enshrine that
particular freedom. That doesn't mean it isn't a worthwhile thing to
enshrine, I just think it is inaccurate to claim that the GPLv2
attempts in any way to enshrine it.

Linus clearly values this freedom very highly, as I'm sure many kernel
developers do. So for those people the GPLv2 license may better
represent their own intentions.

For myself, I value other things more highly. One of the most
important aspects of the GPL for me is the equality between vendors
and recipients of software. I really like the symmetry between giver
and receiver, and the fact that this symmetry is passed on down the
chain, so that someone ten steps away from me as an author ends up
with the same rights that I had.

(There is an exception to this. The copyright holder is the only one
who can sue over a violation of the license, so that is an asymmetry,
but I think it is an essential asymmetry and prevents chaos. When
faced with a GPL violation of my code I have almost always chosen to
work with the violator to bring them into compliance, whereas if
anyone could sue then we'd see lawsuits far too often)

One result of this symmetry is that most GPLd software is 'free as in
beer' as well as 'free as in freedom'. If someone were to start
charging outrageous prices for GPLd software then someone else will
come along and sell it cheaper. That drives down the price to a
reasonable level.

I like the fact that I was able to distribute useful patches for the
kernel in TiVo v1. I didn't like the fact that I had to work around
the binary kernel modules used by TiVo, but I didn't complain too
loudly partly because it was a nice challenge to work around the
problem. I was delighted when TiVo incorporated some of my changes (in
particular a new driver) into their future releases. That was the GPL
working.

With v2 TiVo introduces something which had the potential to make that
impossible, at least for me. Thankfully they didn't get it quite
right, but it certainly made me aware that the symmetry I had been
taking for granted in the GPL was under threat.

So for me this symmetry is more important than the loss of the 'end
users can do what they want' freedom. From my point of view, that
freedom was never part of the 'contract' I had with the FSF, but the
symmetry freedom was, and thus I think the FSF has done well in fixing
a hole in the GPLv2 license.

Finally, I'm curious as to the legal basis of this statement:

> As drafted, this currently looks like it would potentially jeopardise the
> entire patent portfolio of a company simply by the act of placing a GPLv3
> licensed programme on their website.

I can't see anything in the current GPLv3 draft which would do
that. Could you explain how that comes about?

Cheers, Tridge
