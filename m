Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUEXVHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUEXVHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEXVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:07:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:1155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264278AbUEXVFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:05:52 -0400
Date: Mon, 24 May 2004 14:05:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <200405242250.38442.tglx@linutronix.de>
Message-ID: <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
 <200405242250.38442.tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Thomas Gleixner wrote:
> 
> What I'm missing in this discussion is a clear distinction between patches and 
> contributions.

Well, I'm not sure such a clear distinction exists.

Clearly there are patches that are so trivial that we simply don't care 
about the process, because they don't contain any "new work". Spelling 
fixes, and trivial one-liners.

On the other hand, I'd rather have the process be "we always have the 
sign-off", coupled with just plain common sense.

Any process that doesn't allow for common sense is just broken, and
clearly from a _legal_ standpoint it doesn't matter if we track who fixed
out (atrocious) spelling errors.

On the other hand, it if becomes a habit, and we just sign-off even on the 
trivial stuff, that's actually going to make the whole process a lot 
easier - simply by avoiding the bother of even having to think about it.

So I'd rather encourage people to sign off on even the silly stuff, than 
to have to constantly make a judgement call. At the same time, I think 
that if somebody _didn't_ sign off on the simple stuff, we shouldn't just 
run around in circles like hens in a hen-house, we should just say "hey, 
we've got brains, the process isn't meant to be _stupid_".

			Linus
