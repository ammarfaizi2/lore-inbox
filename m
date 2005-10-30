Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVJ3Pqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVJ3Pqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVJ3Pqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:46:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12852 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751020AbVJ3Pqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:46:45 -0500
Date: Sun, 30 Oct 2005 10:46:42 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [git patches] 2.6.x libata updates
In-reply-to: <Pine.LNX.4.64.0510291358330.3348@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510301043150.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051029182228.GA14495@havoc.gtf.org>
 <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com>
 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
 <Pine.LNX.4.64.0510291609140.5288@localhost.localdomain>
 <Pine.LNX.4.64.0510291358330.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005, Linus Torvalds wrote:

> On Sat, 29 Oct 2005, Nicolas Pitre wrote:
> > 
> > Since GIT is real free software that even purists may use without fear, 
> > this downside is certainly not as critical as it was in the BK days.
> 
> I don't think that's the problem.
> 
> It's the learning curve. I don't think git is that hard to use (certainly 
> not if you just follow somebody elses tree and occasionally do a "git 
> bisect"), but git _is_ different. And if you're not a developer, or even 
> if you are, and you're just somebody who has alway sjust used CVS, then 
> something like "patch" is simply to understand what it's doing, with 
> basically no abstractions anywhere. 

Agreed.

> Compared to tar-files + patches, git has a _lot_ of abstract things going 
> on that you have to get used to before you aren't intimidated by it.

Maybe gitweb could be extended to provide any arbitrary patch with a 
front-end to git-bisect...


Nicolas
