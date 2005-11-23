Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVKWCAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVKWCAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVKWCAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:00:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965197AbVKWCAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:00:20 -0500
Date: Tue, 22 Nov 2005 18:00:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: Christmas list for the kernel
Message-Id: <20051122180006.52d0a6bb.akpm@osdl.org>
In-Reply-To: <9e4733910511221709t546089d1id76357256079d8f9@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	<200511221839.24202.s0348365@sms.ed.ac.uk>
	<9e4733910511221110j47e8ddcs1c9936db1eb5f0b4@mail.gmail.com>
	<20051122164353.4177c59a.akpm@osdl.org>
	<9e4733910511221709t546089d1id76357256079d8f9@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > >
> > > On 11/22/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > On Tuesday 22 November 2005 18:31, Jon Smirl wrote:
> > > > > There have been recent comments about the pace of kernel development
> > > > > slowing.
> > > >
> > > > I doubt the diffstat from the last 6 kernel releases will tell this story.
> > >
> > > Andrew Morton said it: "He suggested this may indicate that the kernel
> > > is nearing completion. "Famous last words, but the actual patch volume
> > > _has_ to drop off one day," said Morton. "We have to finish this thing
> > > one day."
> > >
> > > http://news.zdnet.co.uk/software/linuxunix/0,39020390,39221942,00.htm
> > >
> >
> > I was wrong, as usual.  The trend at http://www.zip.com.au/~akpm/x.jpg is,
> > I think, being maintained.
> 
> I wonder what that would look like if you pull Adrian Bunk's changes
> out. He is generating thousands of lines of patches (they're good
> patches but they don't add features).
> 

grep '^[+-]' $(grep -rl '^From:.*Bunk' patches) | wc -l
  59298

59k out of 7M lines changed.
