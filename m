Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbUDFV57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbUDFV57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:57:59 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:36067 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S264027AbUDFV54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:57:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: High CPU temp on Athlon MP w/ recent 2.6 kernels
Date: Tue, 6 Apr 2004 17:57:54 -0400
User-Agent: KMail/1.6
References: <20040406193649.GA13257@sommrey.de> <200404061626.37714.gene.heskett@verizon.net> <20040406204545.GA15946@sommrey.de>
In-Reply-To: <20040406204545.GA15946@sommrey.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061757.54779.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.9.226] at Tue, 6 Apr 2004 16:57:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 16:45, Joerg Sommrey wrote:
>On Tue, Apr 06, 2004 at 04:26:37PM -0400, Gene Heskett wrote:
>> But join the 70C club, that AMD athlon keeps itself at a medium
>> simmer full time.  Mine has been running 67-72C for 3 years now. 
>> Strangly, shutting down setiathome doesn't cool it by more than a
>> couple degrees C.  And, its got a $50 all copper Glaciator cooler
>> on it, heavy heavy heavy.
>
>That's not quite my point.  I am not afraid of running my athlons at
>70C.  I just don't want to.  With Debian Woody they ran at <40C,
> which is impressing IMHO.  An upgrade to Sarge raised the temp for
> about 5K, which is still very cool.  This temperature didn't change
> when I upgraded to an early 2.6 kernel.  Just after 2.6.3-mm4 there
> was this jump for 10K that I just do not understand.  It doesn't
> hurt the athlons but seems unnecessary to me.
>
>-jo

40C?  Shut down for an hour to cool, I've never seen the post on my 
board show less than 63C by the time it gets to that part of the 
bios.  I'm running a 1400DX at 1400mhz, so the bios thinks its a 
1600DX, and I've got vcore set down to 1.65 volts which helps a bit.

Actually, the athlons seem to have a builtin shutdown at 75C, I've hit 
that once or 3 times when the air under the desk was trapped worse 
than usual.  Makes for downright ugly reboots...

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
