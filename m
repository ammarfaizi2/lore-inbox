Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSFURzi>; Fri, 21 Jun 2002 13:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSFURzh>; Fri, 21 Jun 2002 13:55:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41975 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316709AbSFURzg>; Fri, 21 Jun 2002 13:55:36 -0400
Subject: Re: latest linus-2.5 BK broken
From: Robert Love <rml@mvista.com>
To: Larry McVoy <lm@bitmover.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020621105055.D13973@work.bitmover.com>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com>
	<m1r8j1rwbp.fsf@frodo.biederman.org> 
	<20020621105055.D13973@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Jun 2002 10:55:26 -0700
Message-Id: <1024682127.1430.39.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-21 at 10:50, Larry McVoy wrote:

> The real point is that multi threading screws up your kernel.  All the Linux
> hackers are going through the learning curve on threading and think I'm an
> alarmist or a nut.  After Linux works on a 64 way box, I suspect that the
> majority of them will secretly admit that threading does screw up the kernel
> but at that point it's far too late.

Larry, this is a point you have made several times and admittedly one I
agree with.  I fail to see how the high-end scaling will not compromise
the low-end and I am genuinely concerned Linux will become Solaris.

I do not know what to do to prevent it - and I am certainly not saying
we should outright prevent certain things, but it worries me.  You are
going to be in Ottawa next week?  Maybe we can talk about it...

	Robert Love


