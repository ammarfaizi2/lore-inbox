Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUEYECj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUEYECj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUEYECj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:02:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:19386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264560AbUEYECg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:02:36 -0400
Date: Mon, 24 May 2004 21:02:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <20040525034920.GY5414@waste.org>
Message-ID: <Pine.LNX.4.58.0405242100170.32189@ppc970.osdl.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
 <200405242250.38442.tglx@linutronix.de> <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org>
 <20040525034920.GY5414@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Matt Mackall wrote:
> 
> Actually, there is a question as to how to sign off on something that
> eventually gets rolled into something larger? Simply collect all the
> signatories?

Yup.

This is indeed common for people like Andrew (or anybody else who collects 
patches). The only sane thing to do is to just merge the signatories from 
any merged patches.

> > Any process that doesn't allow for common sense is just broken, and
> > clearly from a _legal_ standpoint it doesn't matter if we track who fixed
> > out (atrocious) spelling errors.
> 
> "our"

Ahem.

"I did that on purpose to make a point".

Sure, that's the ticket.

		Linus "ehh, good save" Torvalds
