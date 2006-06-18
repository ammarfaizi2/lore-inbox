Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWFRDa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWFRDa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 23:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFRDa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 23:30:56 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:10961 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751076AbWFRDaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 23:30:55 -0400
Message-ID: <4494C8E7.3080700@ens-lyon.org>
Date: Sat, 17 Jun 2006 23:30:47 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Btw, one thing that I was planning to ask people - does anybody find the 
> full-format ChangeLog's that I produce at all useful?
>
> You can get the exact same information directly from git, and the full 
> changelog (as opposed to the shortlog) tends to be pretty rough to read, 
> so I suspect that most people who do want to delve into the details are 
> actually much more likely to look it up using git instead (at which point 
> you can obviously get much better information - graphical history, diffs, 
> etc)
>
> I'm not going to stop doing the incremental shortlogs, since those are 
> easy to read and I usually post them with the release announcement unless 
> they end up being too large (usually -rc1 has a _lot_ of changes as a 
> result of the merge window), but I'm just wondering if anybody finds the 
> full logs useful at all?
>   

I actually like having the full changelog of every kernels and grep in
all them at once when I want to quickly find out where something has
been added/modified without knowing the exact name of the function or
file that I am looking for.
I guess I could use git to generate the full changelog once a new
release and keep it for later...

Regards,
Brice

