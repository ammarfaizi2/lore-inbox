Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbTCGJXl>; Fri, 7 Mar 2003 04:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261469AbTCGJXk>; Fri, 7 Mar 2003 04:23:40 -0500
Received: from imap.gmx.net ([213.165.65.60]:23736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261468AbTCGJXk>;
	Fri, 7 Mar 2003 04:23:40 -0500
Message-Id: <5.2.0.9.2.20030307103430.00c87df8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 10:38:47 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303071003060.6318-100000@localhost.localdom
 ain>
References: <5.2.0.9.2.20030307093435.01a8fe88@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:03 AM 3/7/2003 +0100, Ingo Molnar wrote:

>here's sched-2.5.64-B0:

KABOOM!  Major explosions on boot.  First time I booted, I got an instant 
reboot.  Second time, I got a couple of double faults and then explosion 
during fsck (uhoh;).  PID is 1684368482 :-/

Time to reboot into .virgin for (hopefully) a couple of fretful 
moments.  (rebooting into .virgin after first explosion would have been a 
bit smarter;)

         -Mike  

