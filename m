Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287662AbRLaVqG>; Mon, 31 Dec 2001 16:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbRLaVpq>; Mon, 31 Dec 2001 16:45:46 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:129 "HELO
	ohdarn.net") by vger.kernel.org with SMTP id <S287656AbRLaVpo>;
	Mon, 31 Dec 2001 16:45:44 -0500
Subject: New tree started ;)
From: Michael Cohen <lkml@ohdarn.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 31 Dec 2001 16:45:42 -0500
Message-Id: <1009835143.7667.0.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Howdy.

After hanging out for a while on openprojects.net, I've decided to
create a new 2.4 tree.  I feel that there's need for a rapidly
developing "-ac alike" tree, and so, here we go.  Feel free to test it. 
I've attached patch-2.4.17-mjc1.bz2.  New versions can be found at
http://iamnotanimatedtoexplode.com/patches/mjc. Currently the patch
includes:

Reverse Mapping patch #9			(Rik van Riel)
Preemptible Kernel Patch			(Robert Love)
Lock-Break Patch				(Robert Love)
CPU affinity /proc entry			(Robert Love)
Netdev-random					(Robert Love)
Software Suspend				(Gabor Kuti?)
Real Time Scheduler for Linux			(?)
IDE updates (Taskfile IO and others)		(Andre Hedrick}

Ideally I'd like to have this maintained (possibly using bk) by those at
#kernelnewbies.  

Linus once said something about having more trees being a good thing. 
I'll try to keep this as close to the 2.4.x line as possible, though. :)

------
Michael Cohen
OhDarn.net

	"Intelligence is the ability to do no work, yet somehow getting 	the
work done."
		-- Linus Torvalds :)

