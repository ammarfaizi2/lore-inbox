Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUEZLfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUEZLfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbUEZLfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:35:25 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:10903 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265489AbUEZLfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:35:10 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 04:38:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040526090928.GW1833@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDASboTN4HzgChRZO/t4ANbwhmjQADN4jQ
Message-Id: <S265489AbUEZLfK/20040526113510Z+1673@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com] 
Sent: Wednesday, May 26, 2004 2:09 AM
To: Buddy Lumpkin
Cc: orders@nodivisions.com; linux-kernel@vger.kernel.org
Subject: Re: why swap at all?

On Wed, May 26, 2004 at 01:30:09AM -0700, Buddy Lumpkin wrote:
> As for your short, two sentence comment below, let me save you the energy
of
> insinuations and translate your message the way I read it: 
> -------------------------------------------------------------------------
> I don't recognize your name, therefore you can't possibly have a valuable
> opinion on the direction VM system development should go. I doubt you have
> an actual performance problem to share, but if you do, please share it and
> go away so that we can work on solving the problem.
> --------------------------------------------------------------------------
> My response:
> Get over yourself.

> What the Hell? I have enough bugs I'm paid to fix that I'm not going to
> tolerate harassment for requesting that claims that the kernel behaves
> pathologically in some scenario be cast as comprehensible bugreports.
> It's also worth noting that paying customers don't respond so uncouthly.


> -- wli

If you follow the thread, you will see no claim from me that there is
anything wrong with the kernel. I simply stated that the priority of VM
system development should focus on physical memory, and that physical memory
access should not suffer as a result of some tradeoff that improves the
performance of the VM system when free physical memory is low and there is
heavy use of the swap device.

I can't speak whether or not a case like this currently exists, but I know
optimizing swap performance is a very complicated yet captivating subject
that has consumed many a posts on this list. People have tried to optimize
every part of the VM before, so I was just calling out what I believe to be
a very reasonable and practical goal and put a little bit of substance
around why I think it's practical.

Anthony DiSante's post was merely a catalyst for discussion as far as I was
conserned, I wasn't implying that I had witnessed any VM system performance
problems as of late.

To address your ranting about paying customers, etc ... 

After reading your message I had to check whether my original post was
addressed to you directly (it wasn't). One might gain the impression that
you were actually directly solicited for your opinion the way your carrying
on about harassment and paying customers ... sheesh, give me a break.

I have seen many cases, where one or more persons create a free application
that many people like, then after a while some of the user base starts to
demand features, and show various signs that they have become too
comfortable with the expectation that the application will continue to
improve and forget that they should be greatful.

This situation isn't even remotely similar. In this case, you (a contributor
to a very, very large FREE software project) misread a thread and made some
surly comments that you ended up eating, and are so used to telling people
that you owe them nothing, that you have some how conjured up the image that
I actually want something from you.

This is classic, you have managed to put yourself in a position where you
spend the majority of your time working on a free project that has some very
ambitious goals. It has afforded you the ability to forfill your own
personal and professional goals as well, yet you reserve the right to
discard all accountability for your actions when it's convenient because you
get some frank feedback from someone that is not a paying customer.

What a crutch.

I can picture where this is going. Here is an interview between you and a
popular Linux magazine in two years:


Linux Magazine: You have contributed to linux for quite some time, correct?

William: Oh yes, it is my hobby and occupation. I love my work.

Linux Magazine: You have done all these wonderful things!

William: Thanks, I am very proud of that

Linux Magazine: Why did you make such and such decision that backfired?

William: I don't have to answer that, I don't owe you anything and your not
a paying customer.

Give me a break.

--Buddy

