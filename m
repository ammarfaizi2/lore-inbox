Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUI1K1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUI1K1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUI1K1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:27:14 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:43393 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S268052AbUI1K0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:26:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Tue, 28 Sep 2004 06:26:50 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Matt Heler <lkml@lpbproductions.com>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409272142.35182.gene.heskett@verizon.net> <20040928070104.GA14836@elte.hu>
In-Reply-To: <20040928070104.GA14836@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409280626.50167.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.46.219] at Tue, 28 Sep 2004 05:26:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 03:01, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Monday 27 September 2004 16:17, Ingo Molnar wrote:
>> >* Matt Heler <lkml@lpbproductions.com> wrote:
>> >> Yup, turning opff pre-emptable bkl makes it boot up and work
>> >> just fine.
>> >
>> >do you know which particular subsystem broke (by comparing the
>> > failed and the successful bootlogs)?
>>
>> How do we save the broken bootlog when the machines only response
>> is to the reset key?
>
>what i use is serial logging to another machine. A digital camera is
>fine too, if the problem area is still visible on the screen.
>(Netconsole is useful too for other type of hangs but it's not
> active at such an early stage yet.)
>
> Ingo

Unforch, I don't have a spare seriel port Ingo.  One is running my x10 
stuffs, and the other is monitoring my belkin ups.  The ups has a usb 
connection too, but belkins monitor soft doesn't support it...  They 
don't have a real strong support linux attitude, and they apparently 
do their linux development on a board with a broken usb1.0 interface, 
like my firewall box's Tyan Trinity S-1590 has.  It does mice ok, but 
hook up anything that can output more than a 5 byte packet and the 
machine is locked up instantly.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
