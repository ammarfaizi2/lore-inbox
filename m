Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUCOUCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbUCOUCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:02:11 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:9670 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262732AbUCOUCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:02:05 -0500
Date: Mon, 15 Mar 2004 12:02:04 -0800
From: Andy Isaacson <adi@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BK/Web improvements (includes patch server)
Message-ID: <20040315200204.GH8249@bitmover.com>
References: <200403150616.i2F6Gu2Z030020@work.bitmover.com> <20040315114142.GA22039@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315114142.GA22039@codepoet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for the dup, Erik.]

On Mon, Mar 15, 2004 at 04:41:42AM -0700, Erik Andersen wrote:
> On Sun Mar 14, 2004 at 10:16:56PM -0800, Larry McVoy wrote:
> > I've made a few changes to the BK/Web service on BK/Bits.  There are some
[snip]
>     <obligitory request for yet more stuff which is
>     almost certain to piss you off since you just
>     gave me yet-another-something-for-free>

Yeah, you should send those messages to me, rather than Larry, 'cuz I
don't get pissed when people say "thanks for bending over, now bend over
farther".

:)

> I'm curious if you might consider adding a diff -Nur style
> patch vs the last tagged version?  I often go to:
>     http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/

This is most profitably done outside of bkbits -- the kernel.org URLs
you point to should work (there's no reason they can't be made to go)
and it's hard to see the payoff to bkbits to providing it internally.

Gotta remember, bkbits is more than just kernel stuff.  We're probably
not going to add code that is only useful to the kernel project.

The stuff larry added this weekend, by comparison, is stuff that makes
our lives better and has a payoff for us and our customers, while
simultaneously making life better for bkbits users.  Win-win.  (Or is
that win-win-win?)

> Of course, an alternative solution would be for someone to fix
> the kernel.org testing/cset/ scripts to not get wedged...

Yeah, go bug somebody else. :)

No, seriously, thanks for the feedback, and I'm glad the patch server
looks to be useful.  I just hope it doesn't suck too much bandwidth.

-andy
