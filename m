Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUG2B7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUG2B7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUG2B7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:59:31 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:39407 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S267408AbUG2B7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:59:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Wed, 28 Jul 2004 21:59:10 -0400
User-Agent: KMail/1.6.82
References: <200407242156.40726.gene.heskett@verizon.net> <200407282059.03524.gene.heskett@verizon.net> <20040729010311.GM2334@holomorphy.com>
In-Reply-To: <20040729010311.GM2334@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407282159.10684.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.153.76.185] at Wed, 28 Jul 2004 20:59:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 July 2004 21:03, William Lee Irwin III wrote:
>On Wed, Jul 28, 2004 at 08:59:03PM -0400, Gene Heskett wrote:
>> This message is now a bit old, William.
>> I was watching the psu voltages via gkrellm, and was seeing the 5
>> volt line go from 4.89, down to 4.73 in consecutive readings.  The
>> new 420 watt Antec, seems to be steadier at 4.87 +- 0.03 or so.
>> I suspect the tap point for the xx83627 chips input may not be
>> right at the psu connector on the mobo cause I suspect the supply
>> itself is probably doing 5.05 or so, although I haven't dropped my
>> DVM on the line to test, its rather buried behind the drive cage. 
>> But lemme go hit a drive power connector since there are spares on
>> this psu, brb. Yeah, at a drive cables middle connector, with a
>> small load on the end, its sitting at 5.00 volts, solid as a rock.
>>  This supply has seperate regulators for the 5 volt, and 3.3 volt
>> lines where the older one regulated everything against the 5 volt
>> by turns ratios on the transformer, and was only a 300 watter,
>> with 2 hd's, 2 floppy's and a dvd writer in addition to the
>> motherboard load.
>> Anything else a C.E.T. can get for you?
>
>The question is really whether all this is actually causing
> observable kernel/cpu/device failures.
>
Well, at this point, I've 'shotgunned' just about everything.  Mobo, 
cpu, memory and psu now.    And a fresh ATI (Xtacy made) 9200SE video 
card, the old nvidia failed and apparently compromised something on 
the old Biostar M7VIB mobo as it was going.  Its now a Biostar 
M7NCD-Pro, with a 2800XP athlon replaceing the 1400XP on the old 
board.   The new memory, 2 sticks of 512Mb, is DDR400 rated.  And I 
just built, and am booted to, 2.6.7.  I'll see how long it stays up.

And despite all this trouble, I'm once again slowly climbing in the 
seti@home ranks :-)

>-- wli

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
