Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUINKv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUINKv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269254AbUINKv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:51:59 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:14786 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S269090AbUINKv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:51:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5, ehci stuff gone
Date: Tue, 14 Sep 2004 06:51:55 -0400
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <200409132307.19242.gene.heskett@verizon.net> <200409140105.32221.gene.heskett@verizon.net> <20040914053140.GA18591@kroah.com>
In-Reply-To: <20040914053140.GA18591@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409140651.55520.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.51.156] at Tue, 14 Sep 2004 05:51:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 01:31, Greg KH wrote:
>On Tue, Sep 14, 2004 at 01:05:32AM -0400, Gene Heskett wrote:
>> On Monday 13 September 2004 23:56, Greg KH wrote:
>> >On Mon, Sep 13, 2004 at 11:07:19PM -0400, Gene Heskett wrote:
>> >> Greetings;
>> >>
>> >> I've rebooted to 2.6.9-rc1-mm5, and found that my 2 printers,
>> >> usb-2.0 capable are not found.  Reverting to -mm4 brings them
>> >> back among the living.
[...]
>> >Anyway, try the following patch from David Brownell, it fixed the
>> > ohci issues that I had in my laptop, and will show up in the
>> > next -mm patch.

[...]

And it worked just fine Greg, thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
