Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310372AbSCGQD4>; Thu, 7 Mar 2002 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310375AbSCGQDr>; Thu, 7 Mar 2002 11:03:47 -0500
Received: from altus.drgw.net ([209.234.73.40]:21771 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S310381AbSCGQDg>;
	Thu, 7 Mar 2002 11:03:36 -0500
Date: Thu, 7 Mar 2002 10:02:39 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Larry McVoy <lm@work.bitmover.com>, Tom Lord <lord@regexps.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Why not an arch mirror for the kernel?
Message-ID: <20020307100239.R1682@altus.drgw.net>
In-Reply-To: <200203071425.GAA06679@morrowfield.home> <20020306190419.E31751@work.bitmover.com> <20020306225652.Q1682@altus.drgw.net> <20020306213238.D3240@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020306213238.D3240@work.bitmover.com>; from lm@bitmover.com on Wed, Mar 06, 2002 at 09:32:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And why Arch and not subversion?  Subversion has more people working on
> it, Collab has put a pile of money into it, it has the Apache guy working
> on it, and Arch has one guy with no money and a pile of shell scripts.
> Come on.  There is nothing free in this life, if one guy and some hacking
> could solve this problem, it would have been solved long ago.

I didn't include subversion because no one has volunteered help make 
gateway stuff from the subversion project. Let's concentrate one gateway 
setup first.

> I don't like gateways because they force everyone down to whatever
> is the highest level of functionality that the weakest system can do.
> It's exactly like a stereo system.  You don't spend $4000 on really nice
> system and then try and drive it with $5 of speaker wire.  It will suck,
> it's as good as the weakest part.  In spite of your claims to the contrary,
> Troy, it is really not in our best interests to make a BK<->$OTHER_SCM
> gateway if that means that BK now works only as well as those other
> SCM systems.  That's just stupid. 

It is not my intention to force any kind of a 'lowest common denominator' 
setup. Going from a system with fewer capabilities to one with greater 
capabilities (i.e., currently arch->bk) is going to require some manual 
intervention from $MAINTAINER.

What I'd like to see is someone volunteer to help develop gateway scripts
(where did all those patchbot people go now?). Then I'd like to see 
someone volunteer to be a maintainer to run a gateway so that people that 
feel arch is a better solution can use it, and those that feel BK is a 
better solution can get on with life and not leave anyone out because they 
may have issues with the bk license, or even real technical issues with 
BK.

Obviously using arch is going to be harder, because it is nowwhere near 
mature as BK is. Some people are willing to make that tradeoff.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
