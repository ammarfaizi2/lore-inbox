Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVK0GLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVK0GLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 01:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVK0GLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 01:11:31 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:24234 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750882AbVK0GLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 01:11:31 -0500
Date: Sun, 27 Nov 2005 01:11:29 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
In-reply-to: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>
Message-id: <200511270111.29831.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 22:23, Martin Drab wrote:
>Hi,
>
>on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load
>(like during kernel compilation for instance, or any compilation of any
>bigger project, for that matter), I hear some beeps comming out of the
> PC speaker. It's like few short beeps per second for a while, then
> silence for few seconds, then a beep here and there, and again, and so
> on. It is quite strange. It happens ever since I remember (I mean in
> kernel versions of course, I have the board for about 1.5 years). I've
> just been kind of ignoring it until now. Does anybody else happen to
> see the same symptoms? What could be the cause of this. Is it
> something about timing? But how come the PC speaker gets kiced in,
> while it's not being used at all (well, at least not intentionally)
> for anything. Perhaps something is writing some ports it is not
> supposed to?
>
>Martin

Usually, thats a sign of cpu overheating.  At 18 months, if the cpu
fan/heat sink hasn't been blown out by an air hose, its so packed full
of dust bunnies that no amount of rpms can force any air thru the cpu's 
heat
sink fins.

If its been doing it for a while, I expect the grease between the
bottom of the heat sink and the top pf the cpu has also dried out and
is no longer as effective at moving the heat from the cpu into the
heat sink itself.  So its probably a good idea to do a shut down,
remove the heat sink/fan combo, clean it all up and put a dab of new
grease under the heat sink before ytou clip it back on.  I'm partial
to a fancy bit of stuff called artic silver, which when fresh, is
pretty darned good at moving the heat.

If you aren't comfortable doing all that, find someone who is.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

