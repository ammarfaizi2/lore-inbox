Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVAEHEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVAEHEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 02:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVAEHEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 02:04:14 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:24062 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262247AbVAEHEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 02:04:09 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Date: Wed, 5 Jan 2005 02:04:04 -0500
User-Agent: KMail/1.7
Cc: Willy Tarreau <willy@w.ods.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Thomas Graf <tgraf@suug.ch>,
       Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, wli@holomorphy.com,
       aebr@win.tue.nl, solt2@dns.toxicfilms.tv
References: <20050104031229.GE26856@postel.suug.ch> <200501041850.20446.gene.heskett@verizon.net> <20050105053701.GB24263@alpha.home.local>
In-Reply-To: <20050105053701.GB24263@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501050204.05708.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.52.185] at Wed, 5 Jan 2005 01:04:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 January 2005 00:37, Willy Tarreau wrote:
>On Tue, Jan 04, 2005 at 06:50:20PM -0500, Gene Heskett wrote:
>> I disagree Willy, if I see an -rc candidate, even if I'm following
>> an interesting thread, like Ingo's patches, the rc will get built
>> and run here, precisely so I can bitch if it doesn't work.  I have
>> an idea there are more like me who are interested as much in whats
>> *new* as in how well does it run *my* stuff, and that you may
>> possibly be undercounting us...
>
>I do this too when I have time, but basically, the number of testers
>is limited to a small percent of the amount of LKML readers. This is
>why I say it does not get tested on a large scale. Seeing that even
>slashdot announces new releases, I suspect that releases are tested
>by 10 or 100 times more users than -rc. If we spend too much time
>waiting for a few hundred people to test -rc, it is with great
> deception that we discover that obvious bugs go to the final
> release unnoticed, like the NFS problem on 2.6.8 which hit me on
> the first boot. OK, I would have seen it in -rc, but I didn't have
> time to test -rc this time, and nobody else did enough testing on
> it. Result, -rc did not serve to catch this obvious one. I agree
> that a very few days should be better than absolutely nothing, at
> least to catch build problems, but we should not wait too long.
>

FWIW Willy, I did build a couple of the rc's there (coming up on 
2.6.8), now of course entropy has set in and I couldn't prove it, the 
space has been reclaimed, whatever.  My point is that the rc's didn't 
bite me, only the final, and it bit hard.

Again, to TPTB, give us a few days to beat on it in the rc mode, then 
rename whats working to final.  In the meantime, I'm back to beating 
on Ingo's stuff for the moment.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
