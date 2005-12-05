Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVLEANO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVLEANO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 19:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVLEANO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 19:13:14 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:21755 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932274AbVLEANO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 19:13:14 -0500
Date: Sun, 04 Dec 2005 19:16:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc5: off-line for a week
In-reply-to: <43935C29.3050602@m1k.net>
To: linux-kernel@vger.kernel.org
Message-id: <200512041916.43643.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
 <200512041547.05151.gene.heskett@verizon.net> <43935C29.3050602@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 16:14, Michael Krufky wrote:
>Gene Heskett wrote:
>>On Sunday 04 December 2005 13:50, Michael Krufky wrote:
[...]
>>>Gene, in the meantime, you can fix your situation without changing
>>> any code by simply issuing the following command:
>>>
>>>modprobe tda9887
>>>
>>>Ta - da! Magic!
>>
>>Before, or after, the "modprobe cx88-dvb" in my rc.local that loads it
>>all, ask somewhat tongue in cheek, because I already rebuilt
>>and rebooted to the fixed version.  It Just Works(TM) :-)  But I'll
>> try that for rc6 if it doesn't work.
>>
>>>Cheers,
>>>
>>>Michael Krufky
>
>AFTER.
>
Ok, great.  I'll quit worrying about it then, until it quits again that
is. :-)

>...but it's moot. Linus has already applied the correct fix from Mauro
>and I, 1st patch after -rc5:
>
>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=
>commit;h=e4f5c82a92c2a546a16af1614114eec19120e40a
>
>:-)
>
>Cheers,
>
>-Mike

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

