Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263637AbREYIYt>; Fri, 25 May 2001 04:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263639AbREYIYc>; Fri, 25 May 2001 04:24:32 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7172 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263636AbREYIYU>;
	Fri, 25 May 2001 04:24:20 -0400
Date: Wed, 23 May 2001 16:26:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hua Zhong <huaz@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CRAK: a process checkpoint/restart kernel module
Message-ID: <20010523162603.A33@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0105210555220.20626-100000@razor.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0105210555220.20626-100000@razor.cs.columbia.edu>; from huaz@cs.columbia.edu on Mon, May 21, 2001 at 05:57:52AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!!

> This project has been there for over one year, and I've got quite a few
> emails asking about it.  Before it becomes more reliable, I think letting
> more people know about it is a good idea.  Thanks to those who ever
> pushed me on it :-)
> 
> I guess many of you have already known about epckpt, a patch written
> by Eduardo Pinheiro that adds process checkpoint/restart capability to the
> Linux kernel.  CRAK does the similar thing - in fact, I started this
> project based on epckpt's code, but now they have been very different.

One question: can crak be used for process migration (assuming nodes
share filesystem)? [As in, node of
cluster is going down so we checkpoint and resume on some other node?]

								Pavel
PS: Can it checkpoint/restart X applications? I guess some games would
be easier with ability to checkpoint ;-)
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

