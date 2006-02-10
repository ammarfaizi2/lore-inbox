Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWBJTkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWBJTkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWBJTkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:40:21 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:11605 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751320AbWBJTkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:40:20 -0500
Date: Fri, 10 Feb 2006 14:39:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD
 writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring
 up a hornets' nest) ]]
In-reply-to: <43ECE734.5010907@cfl.rr.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602101439.53394.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 14:19, Phillip Susi wrote:
>Marc Koschewski wrote:
>> I just tried blanking a CD-RW with the latest -git tree. The machine
>> just became unresponsive and then froze. When it became unresponsive
>> the clock in GNOME still displayed the current time but I could not
>> focus any windows anymore. Then I had to hard reboot the machine.
>> The logs say nothing. I repeat: nothing.
>>
>> Does anyone have similar problems?
>
>Instead of rebooting, just wait for the blanking to finish.  My guess
> is that your burner and hard drive are both on the same ide channel,
> and so you can not access the disk while the burner is blanking.  If
> this is the case, put each drive on their own ide channel.
>
It takes hard drive access to switch window focus? Yes, thats a 
question.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
