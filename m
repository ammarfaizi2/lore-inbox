Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUHSOu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUHSOu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHSOuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:50:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43395 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266349AbUHSOqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:46:19 -0400
Date: Thu, 19 Aug 2004 10:46:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nigel Rantor <wiggly@wiggly.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CD/DVD record
In-Reply-To: <4124AD0B.6090908@wiggly.org>
Message-ID: <Pine.LNX.4.53.0408191041430.19454@chaos>
References: <Pine.LNX.4.53.0408190917140.19253@chaos> <4124AD0B.6090908@wiggly.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Nigel Rantor wrote:

> Richard B. Johnson wrote:
> > Hello all...
> > Recording this stuff is basically sending some commands to
> > a device and then keeping a FIFO full until done.
>
> Lots of things that are easy to sum up on one sentence turn out the be
> hairy as a wookie, but yes, it does seem like a Simple(tm) problem.
>

Yes. There are hardware bugs (I once though bug was a reserved-
for-software word), moths are hardware problems ... Anyway...
some thought to putting all the differences in some writable
ASCII text and writing a program around that might be more
useful than complaining about an author's insistance upon
using some "strange at least for Unix" device naming scheme.

> > If `cdrecord` doesn't do it, one can hack together something
> > that works in a day or so,... really good stuff in a week.
>
> Hmm...not sure about that. Not if you do want device specific fixes in
> there too...
>

Back to the parse-stuff-in-a-file idea.

> > Maybe it's time to ......  anyway ..... the device characteristics
> > should be kept in an ASCII text file so the software doesn't have
> > to be re-written everytime a new CD recorder becomes available.
>
> Sounds good.
>
> > Maybe the `cdrecord` author needs some competition. This sounds
> > like a good beginner's project....
>
> I'll admit to having some time on my hands but acquiring equipment to
> test with would be a stumbling block for me.
>
> It would be nice if everyone could just put their egos aside and provide
> a united front wrt FOSS cd/dvd recording.
>
> I was going to make some suggestions about how to do the above but then
> I have also been following the cdrecord thread and I'm not sure wading
> in on that makes sense...
>
>    N
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


