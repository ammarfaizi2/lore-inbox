Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVJaGv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVJaGv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVJaGvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:51:55 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16904 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751392AbVJaGvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:51:52 -0500
Date: Mon, 31 Oct 2005 07:41:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <20051031064109.GO22601@alpha.home.local>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com> <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 01:28:23PM -0700, Linus Torvalds wrote:
 
> So I'm planning on continuing with it unchanged for now. Two-week merge 
> window until -rc1, and then another -rc kernel roughly every week until 
> release. With the goal being 6 weeks, and 8 weeks being ok.
> 
> I don't think anybody has been really unhappy with this approach? Hmm?

I believe it was a good experience. However, I still find it sad that
there are changes between the latest -rc and the final version. This
time, it seems it did not cause trouble, but in the past, it happened
several times, because any valid fix can have side effects.

I think that if you could announce what you intend to release with a
message like "I will make this -final tomorrow", there would be some
time to test builds in various configs, and check that no obvious bug
has been introduced.

Regards,
Willy

