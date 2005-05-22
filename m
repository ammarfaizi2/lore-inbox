Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVEVWYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVEVWYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEVWYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 18:24:51 -0400
Received: from [81.2.110.250] ([81.2.110.250]:22174 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261755AbVEVWYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 18:24:32 -0400
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi
	SuperIO chip
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505221438260.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
	 <1116763033.19183.14.camel@localhost.localdomain>
	 <20050522135943.E12146@flint.arm.linux.org.uk>
	 <20050522144123.F12146@flint.arm.linux.org.uk>
	 <1116796612.5730.15.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505221438260.2307@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116800555.5744.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 May 2005 23:22:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-05-22 at 22:50, Linus Torvalds wrote:
> You mean DCO, not OSDL ("Developer's Certificate of Origin").
> 
> And yes, I'll update the SubmittingPatches to state explicitly that the 
> sign-off is a public record.

The DCO yes.

> So how about just something like the appended? Along with making a very 
> public announcement on linux-kernel for the next kernel release (rather 
> than this discussion that is taking place under a fairly obscure subject), 
> that should make sure that people are aware of the fact that the thing 
> isn't exactly private.

It actually doesn't help. EU privacy law rather sensibly is "opt-in".
Putting the statement in the DCO, which is a document and submission
agreement works because you have to agree to it, putting it in a
document is probably not "opt-in".

You have to -actively- agree to the DCO to submit a change, and that is
what makes it work (whether you put something in submitting patches or
not that is more explanatory).


