Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVJaBLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVJaBLz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJaBLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:11:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751175AbVJaBLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:11:54 -0500
Date: Sun, 30 Oct 2005 17:10:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: rmk+lkml@arm.linux.org.uk, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030171053.1c3b7a06.akpm@osdl.org>
In-Reply-To: <200510310148.57021.ak@suse.de>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051029223723.GJ14039@flint.arm.linux.org.uk>
	<20051030111241.74c5b1a6.akpm@osdl.org>
	<200510310148.57021.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Sunday 30 October 2005 20:12, Andrew Morton wrote:
> 
> > The freezes are for fixing bugs, especially recent regressions.  There's no
> > shortage of them, you know.
> >
> > I you can think of a better way to get kernel developers off their butts
> > and actually fixing bugs, I'm all ears.
> 
> The problem is that you usually cannot do proper bug fixing because
> the release might be just around the corner, so you typically
> chose the ugly workaround or revert, or just reject changes for bugs that a 
> are too risky or the impact too low because there is not enough time to 
> properly test anymore.

There is absolutely nothing preventing people from working on bugs at any
time!  It's not as if a bugfix can ever come too early.

> It might work better if we were told when the releases would actually
> happen and you don't need to fear that this not quite tested everywhere
> bugfix you're about to submit might make it into the gold kernel, breaking
> the world for some subset of users.

Nobody knows when a kernel will be released, because it's released
according to perceived bug status, not according to a preconceived
timeline.

I just don't buy what you're saying.  Unless the kernel is at -rc3 or -rc4,
we *know* the release is weeks away - it's always been thus.
