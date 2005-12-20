Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVLTWVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVLTWVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVLTWVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:21:04 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62873 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932188AbVLTWVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:21:02 -0500
Date: Tue, 20 Dec 2005 17:19:15 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Nicolas Pitre <nico@cam.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
In-Reply-To: <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0512201716420.25296@gandalf.stny.rr.com>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org> <20051220193423.GC24199@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org>
 <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Linus Torvalds wrote:
>
> In other words: if people didn't mix up issues that had nothing to do with
> this into it, I'd be happier. I've already said that a mutex that does
> _not_ replace semaphore (and doesn't mess with naming) is acceptable.
>

At least I'm very happy with Linus' decision.  Can we now end this thread,
and move forward.  You may bring up your issues in what comes next.

Thank you,

-- Steve

