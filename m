Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264994AbUEYRzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbUEYRzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUEYRxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:53:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:38841 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264994AbUEYRxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:53:00 -0400
Date: Tue, 25 May 2004 10:52:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Valdis.Kletnieks@vt.edu
cc: "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission 
In-Reply-To: <200405251740.i4PHeQJY014847@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0405251049520.9951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>           
 <40B369D5.7070805@timesys.com> <200405251740.i4PHeQJY014847@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004 Valdis.Kletnieks@vt.edu wrote:
> 
> It's unclear (at least to me) whether your issue is:
> 
> a) You're submitting patches that consist of GPL'able code that you don't have
> the company-internal paperwork in place to authorize the release; or

No, if I understood correctly he _does_ have all the rights internally,
and it's just that he didn't write it, so (a) doesn't apply, and because
the people who _did_ write it are all internal and don't themselves have
the right to release it as GPL, (b) doesn't apply either (the "preexisting
work" wasn't GPL'd, but it will be once he follows the rules).

Technically, I do believe (b) applies just because if he has the right to 
make it GPL'd, then he can (and should) just exercise that right _before_ 
he agrees to sign it off as per (b).

So I think the current DCO thing should be ok.

I really didn't want this to degrade into some lawyerese, and I _really_
don't want the "certificate of origin" to become some horrible thing that 
only a lawyer could love.

		Linus
