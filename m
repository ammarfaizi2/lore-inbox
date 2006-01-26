Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWAZTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWAZTwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWAZTwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:52:20 -0500
Received: from relay03.pair.com ([209.68.5.17]:17671 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751392AbWAZTwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:52:19 -0500
X-pair-Authenticated: 67.163.102.102
Date: Thu, 26 Jan 2006 13:52:16 -0600 (CST)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Marc Perkel <marc@perkel.com>
cc: Chase Venters <chase.venters@clientec.com>,
       Diego Calleja <diegocg@gmail.com>, Paul Jakma <paul@clubi.ie>,
       torvalds@osdl.org, linux-os@analogic.com, mrmacman_g4@mac.com,
       jmerkey@wolfmountaingroup.com, pmclean@cs.ubishops.ca,
       shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43D92175.6010804@perkel.com>
Message-ID: <Pine.LNX.4.64.0601261344220.17514@turbotaz.ourhouse>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org>
 <20060126195323.d553a4b8.diegocg@gmail.com> <Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
 <43D92175.6010804@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Marc Perkel wrote:

> There seems to be some confusion about licensing. I'm just going to see if I 
> can define the problem and the issues.
>
> First - some people think all of Linux is under GPLv2 - but some people seem 
> to think it's really GPLv2 or later. That needs to be resolved. Can different 
> parts of Linux be controlled by multiple licenses. If so - that could create 
> confusion because someone would have to agree to all the licenses within 
> Linux in order to use it. The alternative is to say it's all GPLv2 and 
> exclude GPLv3 from inclusion. Do we want to do that.

I don't think there are any questions about what the "whole" of Linux is 
governed under. It's governed by whatever the most 'restrictive' license 
usage is, which is 'GPLv2 Only'. (The fact that GPLv2 Only doesn't apply 
to the whole kernel or perhaps even to some past kernels doesn't matter - 
you still can't package the whole as GPLv3)

The only discussion I see taking place any longer is basically irrelevant 
to Linux and GPLv3 - it concerns whether or not other, older kernel 
releases were legally GPLv2 Only or not. A disagreement on either the 
intent, mechanism or action of parts of the GPL license, if you will.

> Second - is GPLv3 Linux compatible. If Linux were to start over today would 
> it pick GPLv2 or GPLv3? Is there anything in GPLv3 that is not Linux 
> compatible. I would at least like to see GPLv3 (final draft) to be 100% Linux 
> compatible.

What does Linux compatible mean? Linus expressed some frustrations with 
some of the new terms, so perhaps in that sense the new license is not 
compatible.

If I'm reading him right, he doesn't want to restrain vendors like TiVO 
from using the kernel and subsequently refusing to provide the public with 
encryption keys necessary to build kernels to run on that hardware (for 
example).

> Suppose GPLv3 were Linux compatible and many existing authors and new authors 
> adopted GPLv3 but dead authors and some stubborn people and people who can't 
> be found are still at GPLv2. Lets also assume that critical parts of Linux 
> code are licensed in both worlds. What dos that mean? Does that mean that 
> GPLv3 prevails?

It's mental masturbation at this point. Suppose Linus approved of going to 
GPLv3... there may be some little technical gotchas in terms of "dead 
authors", but in that hypothetical, how many people would really be 
worried that the descendents of these dead authors would actively act to 
stop Linux from being distributed under the new license?

The bigger issue is that no matter where you fall on GPL's section 9, 
_lots_ of code is undoubtedly GPLv2 only. These living authors would have 
to agree to GPLv3, and as we now know, Linus does not.

> This is something that might be worth doing some serious legal work on 
> because if we do it wrong it could bite us hard in the future. But I want to 
> try to properly raise the question here so that we all at least understand 
> the problem.

Why? I think it's pretty much a dead issue.

Cheers,
Chase
