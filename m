Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVF3Gux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVF3Gux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVF3Guw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:50:52 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:3284 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262690AbVF3Guo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:50:44 -0400
Date: Thu, 30 Jun 2005 02:50:35 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Bill Huey <bhuey@lnxw.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
In-Reply-To: <20050630021837.GA24343@nietzsche.lynx.com>
Message-ID: <Pine.LNX.4.58.0506300238360.14989@localhost.localdomain>
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com>
 <20050629235422.GI1299@us.ibm.com> <20050630015041.GA24234@nietzsche.lynx.com>
 <42C35167.1090607@yahoo.com.au> <20050630021441.GA24287@nietzsche.lynx.com>
 <42C35440.8010703@yahoo.com.au> <20050630021837.GA24343@nietzsche.lynx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Jun 2005, Bill Huey wrote:

> On Thu, Jun 30, 2005 at 12:09:04PM +1000, Nick Piggin wrote:
> > What part of "drop me from your cc list" were you having trouble
> > understanding?
>
> Then don't comment or reply to these emails and use some kind of
> condescending tone.
>
> bill
>

Bill,

I'm on your side of the issue here, and I have a high stake in going with
Ingo's RT patch.  If you want to be listened to, don't insult people or
just get angry in your posts.  Best thing to do is let Ingo reply, since
he will do his best to find out why the numbers are the way they are, and
fix the situation.  The RT patch still has far to go and these tests help
(even if they show a bad light on RT), because Ingo and company will
most likely show where the tests have failed, or if it is RT that failed,
we can fix it.  This is just like the MS benchmarks against Linux, they
actually showed where Linux had a bottle neck, and although people
complained that MS was setting up the test to hurt Linux, it actually
found a problem with Linux that was quickly fixed.  So we can thank MS in
making Linux a more competitive OS.

Kristian and Karim have put a lot of effort into understanding the RT
patch (thanks guys!) and we should appreciate it.  I don't really believe
that they are trying to hurt RT (like MS was with Linux), they are just
trying to make real comparisons.  In the end, I strongly believe that
their work will help the RT patch.

-- Steve

