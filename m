Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUJQOP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUJQOP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269136AbUJQOP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 10:15:59 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:35239 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S269135AbUJQOP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 10:15:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: I/O card vs linux
Date: Sun, 17 Oct 2004 10:15:55 -0400
User-Agent: KMail/1.7
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <200410160423.43597.gene.heskett@verizon.net> <20041017121831.GH5033@lug-owl.de>
In-Reply-To: <20041017121831.GH5033@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410171015.55605.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.58.180] at Sun, 17 Oct 2004 09:15:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 October 2004 08:18, Jan-Benedict Glaw wrote:
>On Sat, 2004-10-16 04:23:43 -0400, Gene Heskett
> <gene.heskett@verizon.net>
>
>wrote in message <200410160423.43597.gene.heskett@verizon.net>:
>> Greetings;
>>
>> This may be OT, but can anyone advise me on a pci card thats
>> basicly an 8255 with a 34 pin or greater port on the card or back
>> panel to bring out all 3 ports, and a suitable linux compatible
>> driver for it?
>
>For input? Output? Both? In the output-only with low "bandwith"
> being okay, just think about attaching a number of
> serial-in-parallel-out shift registers to your parport. I use
> something like that for switching on and off computers...
>
>MfG, JBG

Both, to drive a small homemade cnc milling machine. I found a pci 
card with 3 each 8255's on it for about 75$, but I don't think it 
meets the pci std, I don't think there's a bios on it.  We'll see 
when it gets here.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
