Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbTCGMjX>; Fri, 7 Mar 2003 07:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbTCGMjX>; Fri, 7 Mar 2003 07:39:23 -0500
Received: from pop.gmx.net ([213.165.65.60]:680 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261557AbTCGMjW>;
	Fri, 7 Mar 2003 07:39:22 -0500
Message-Id: <5.2.0.9.2.20030307134220.00c80740@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 13:54:27 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.2.20030307111755.00ce7848@pop.gmx.net>
References: <Pine.LNX.4.44.0303071049500.7326-100000@localhost.localdomain>
 <5.2.0.9.2.20030307103430.00c87df8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:23 AM 3/7/2003 +0100, Mike Galbraith wrote:
>At 11:03 AM 3/7/2003 +0100, Ingo Molnar wrote:
>
>>i've attached the -B2 patch (against vanilla 2.5.64).....
>
>(I'll test and report back in an hour or so...

B2 appears to fix my interactivity woes w. X + make -j5 bzImage.  I can now 
waggle windows to my heart's content, browse around and click on RFC's and 
such and they pop up with nice response times.  Spiffy :)  /Me thinks 
desktop users will like this patch a bunch.

         -Mike

(I'd really like to see a multi-client db load time-to-query comparison 
though.  that make -j30 weirdness might not be a bad thing, but it makes me 
nervous [worry wart])


