Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267750AbUHEO1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267750AbUHEO1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUHEOXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:23:38 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:21150 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S267731AbUHEOTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:19:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 10:19:44 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408050031.21366.gene.heskett@verizon.net> <200408051133.44684.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408051133.44684.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408051019.44268.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [141.153.92.242] at Thu, 5 Aug 2004 09:19:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 04:33, Denis Vlasenko wrote:
>> Well, it has, in the past week, ran memtest86-3a for 12 full
>> passes over the whole gig of ram with no errors.  This was the
>> longest test, I gave it a 2 hour, 5 pass test before I ever booted
>> linux the first time on this motherboard over 2 weeks ago now, a
>> new Biostar M7NCD-Pro, with an nforce2(3?) chipset.  I did that
>> because I was comeing from an older board whose memory had been
>> overstressed by a failing video card and I wanted to make sure
>> this new memory, nearly $210 worth of it, was good. I gave it
>> another, probably 4 hour test after the first couple of crashes,
>> which it also passed.  And it got
>
>You may use cpuburn to test RAM/CPU too.

Setiathome should be doing a pretty good job of that, the cpu is at 
100% 99.99% of the time.  Only going down for a few seconds as its 
managing script switches the link to a new data packet directory when 
its done with the current one.  I keep 101 packets cached here. :)

>Although I have a memory which, when clocked a bit too high,
>pass both memtest86 and cpuburn for extended periods of time,
>yet large compile runs die with sig11 sometimes. Using a tiny
>bit less aggressive clocking helped. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
