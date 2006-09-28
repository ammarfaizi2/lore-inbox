Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWI1PAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWI1PAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWI1PAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:00:07 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:43466 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1161172AbWI1PAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:00:04 -0400
Date: Thu, 28 Sep 2006 16:59:38 +0200
From: DervishD <lkml@dervishd.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Linus Torvalds <torvalds@osdl.org>,
       Patrick McFarland <diablod3@gmail.com>, Theodore Tso <tytso@mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060928145938.GA1474@DervishD>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Chase Venters <chase.venters@clientec.com>,
	Sergey Panov <sipan@sipan.org>, Linus Torvalds <torvalds@osdl.org>,
	Patrick McFarland <diablod3@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org> <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca> <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928144028.GA21814@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jörn :)

 * Jörn Engel <joern@wohnheim.fh-wedel.de> dixit:
> On Thu, 28 September 2006 16:19:32 +0200, DervishD wrote:
> >     Probably the renaming is just common sense and will avoid ALL
> > problems. People like me are concerned only because all GPLv2 that
> > doesn't state otherwise will be released automagically under GPLv3 as
> > soon as the latest draft is made the official version. Otherwise, I
> > wouldn't give a hump about any new license until I have the time to
> > read it and see if I like it.
> 
> In my very uninformed opinion, your problem is a very minor one. 
> Your "v2 or later" code won't get the license v2 removed, it will
> become dual "v2 or v3" licensed.  And assuming that v3 only adds
> restrictions and doesn't allow the licensee any additional rights,
> you, as the author, shouldn't have to worry much.

    Really my problem is that I still don't fully understand neither
the new license nor the possible effects, so just in case I want to
decide if I want my code dual licensed or not. It's not a big worry,
I know, but I prefer things that way.

> The problem arises later.  As with BSD/GPL dual licensed code,
> where anyone can take the code and relicense it as either BSD or
> GPL, "v2 or v3" code can get relicensed as v3 only.  At this point,
> nothing is lost, as the identical "v2 or v3" code still exists. 
> But with further development on the "v3 only" branch, you have a
> fork.  And one that doesn't just require technical means to get
> merged back, but has legal restrictions.

    See? I didn't have seen things from this point of view, and
that's the kind of problems I want to be aware of before allowing my
code to be dual licensed.

> And here the kernel wording with "v2 only" in the kernel is
> interesting.  It turns a one-way compatibility into no
> compatibility at all.  So the evolutionary advantage is lost, as it
> only exists through the "v2 or later" term.

    Well, in my code that's exactly what I want regarding licenses.
Probably GPLv3 is better (I don't know yet) and probably GPLv4 will
be the best license out there, but I prefer to be precise about what
license do I use.

    Thanks for your explanations :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
