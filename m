Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270809AbTHOUFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTHOUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:05:24 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:15066 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S270809AbTHOUFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:05:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.4.21 USB printer failure w/ HP PSC750
Date: Fri, 15 Aug 2003 16:05:16 -0400
User-Agent: KMail/1.5.1
Cc: Peter Denison <lkml@marshadder.uklinux.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0308151220030.1137-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0308151220030.1137-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308151605.16433.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.60.66] at Fri, 15 Aug 2003 15:05:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 August 2003 12:25, Alan Stern wrote:
>On Fri, 15 Aug 2003, Gene Heskett wrote:
>> I can confirm that this does not appear to be printer related,
>> this nearly exact scenario just happened to me while running
>> test3-mm2.  So I powered down the printer, in this case an Epson
>> C82 being driven by cups, and then rebooted to 2.4.22-rc2.  Where
>> it also refused to print, until I went to the local cups page and
>> "started" both printers, which had been apparently disabled by the
>> above failure and it carried over the reboot from 2.6.0-test3-mm2
>> to 2.4.22-rc2.  Once the printer was 'started' then the 3 jobs I'd
>> sent were spit right out normally.
>>
>> It appears that usblp still has problems as of 2.6.0-test3-mm2.
>
>There was a recent change to usblp for 2.6.0, reversing a prior
> patch which broke the driver somehow.  See
>
>http://sourceforge.net/mailarchive/forum.php?thread_id=2931846&forum
>_id=5398
>
>I don't know whether or not this change is already incorporated in
> the version you're using.
>
>Alan Stern

I don't believe it is Alan, and it will now have to wait till late 
October and my return from putting out a few fires at a sister tv 
station.

By then maybe 2.6.0-rc3 will be out?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

