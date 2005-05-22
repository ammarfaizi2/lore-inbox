Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVEVU3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVEVU3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEVU3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 16:29:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:29375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbVEVU3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 16:29:16 -0400
Date: Sun, 22 May 2005 13:31:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO
 chip
In-Reply-To: <20050522200344.B9854@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0505221324300.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
 <1116763033.19183.14.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org>
 <1116785646.6285.24.camel@laptopd505.fenrus.org> <20050522194438.A9854@flint.arm.linux.org.uk>
 <1116787877.6285.26.camel@laptopd505.fenrus.org> <20050522200344.B9854@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 May 2005, Russell King wrote:
> 
> Therefore, I put forward that this thing which appears to be called
> "author" does not reflect authorship, but who submitted it.

It _is_ supposed to reflect authorship, but it does so within the context 
of the SCM, not in any other larger context. In git, "author:" is a fairly 
descriptive TAG, nothing more.

Don't get hung up about technicalities. If the field said

	frog: Arjan van de Ven <arjan@infradead.org>

that wouldn't mean that Arjan would have been magically transformed into a
frog in the real world sense, would it?

The fact that the field says "author:" does not mean that the person named
is necessarily the "author" in the _copyright_ sense, it only means that
he is the author in the limited sense that "git" gives it. And in the 
limited "git" sense, it's really an educated guess, aka "we're tryign to 
give credit where credit is due".

The fact is, trying to be technical about single words in human language
and thinking that that a meaning in one specific context carries over to
some other usage of a word in another context is simply not true. Not 
here, not _anywhere_. 

And btw, lawyers and judges aren't idiots either. They're human beings, 
and they can tell the difference between two contexts. Trying to argue 
some silly technicality with a judge is not likely to get you very far in 
general.

		Linus
