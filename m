Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWFRCGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWFRCGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 22:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWFRCGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 22:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932065AbWFRCGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 22:06:19 -0400
Date: Sat, 17 Jun 2006 19:06:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17
In-Reply-To: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Jun 2006, Linus Torvalds wrote:
> 
> Not a lot of changes since the last -rc, the bulk is actually some 
> last-minute MIPS updates and s390 futex changes, the rest tend to be 
> various very small fixes that trickled in over the last week.

Btw, one thing that I was planning to ask people - does anybody find the 
full-format ChangeLog's that I produce at all useful?

You can get the exact same information directly from git, and the full 
changelog (as opposed to the shortlog) tends to be pretty rough to read, 
so I suspect that most people who do want to delve into the details are 
actually much more likely to look it up using git instead (at which point 
you can obviously get much better information - graphical history, diffs, 
etc)

I'm not going to stop doing the incremental shortlogs, since those are 
easy to read and I usually post them with the release announcement unless 
they end up being too large (usually -rc1 has a _lot_ of changes as a 
result of the merge window), but I'm just wondering if anybody finds the 
full logs useful at all?

They're easy for me to generate, but if nobody uses them, I don't see much 
of a point..

			Linus
