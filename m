Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSCEVvD>; Tue, 5 Mar 2002 16:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSCEVuy>; Tue, 5 Mar 2002 16:50:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20230 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291753AbSCEVum>; Tue, 5 Mar 2002 16:50:42 -0500
Date: Tue, 5 Mar 2002 16:49:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: dart <dart@windeath.2y.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree 
In-Reply-To: <3C7F22A7.BA7916DF@windeath.2y.net>
Message-ID: <Pine.LNX.3.96.1020305162547.28458B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, dart wrote:

> <massive snippage>
> 
> > That sounds very nice, but in practice it means it would never happen, and
> > you know it.
> 
> Excuse me...I've been a lurker and sometimes tester since 2.0.*. I've
> been working my way through man (3) to learn enough to submit a coherent
> patch and I don't appreciate you telling me I can't do it. I've searched
> your submissions to LKML and all I see are opinions, ie ==
> !code_submitted. 

  Correct, after sending in patches to people who didn't bother to ack
them (except Alan), I got the message and stopped bothering people.  Since
I've been writing software for a living longer than there's been a Linux,
I always provide a description of the bug with a test if needed. 
Somewhere around 2.1 I let it ride, and I haven't even followed lkml until
about six months ago. 
 
> > This process could take six months to a year, after which we can start the
> > process with the scheduler.
> 
> Who exactly are "we" anyway? I know it's not me because I haven't
> contributed DIDDLY for code just yet. 

  People who would like to see better performance in *this* stable kernel,
not 2.6 in two years (look at the jump from stable 2.2 to whatever you
think is stable in 2.4 and tell me your estimate).

  I won't bring it up again, I'd love to think Rik, Alan and Ingo will
keep working on performance patches for 2.4, but I wouldn't bet on it.
 
> Just a note: CD Burner, Parport/ECP/EPP/Zip broken with 2.4.17, will try
> 2.4.19. 2.4.18 too ugly to test. 

  I have no idea if this is related to the fix posted recently WRT PL/IP,
after I commented that I was looking at the code to see why it changed
someone asked if 19-pre2 didn't work. I admit I only looked to see if the
change which broke it was reverted, but it looks as if some work has been
done in -pre2, might be worth a try. I'm going to build pre2-ac2 and mjc
for some laptop benchmarks, I'll turn on ZIP support and try my old unit
(the original protocol). I'll try to report back on that in the next day
or so.

  If I brought my laplink cable with me I might give PL/IP a try this
week, otherwise I'll bring it next week, the weekend is being better spent
on ECAC hockey playoffs ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

