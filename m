Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbTGQJcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTGQJcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:32:24 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:22258 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP id S271353AbTGQJcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:32:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Greg KH <greg@kroah.com>
Subject: Re: [BK PATCH] USB update for 2.4.22-pre5
Date: Thu, 17 Jul 2003 05:47:03 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030714170817.GA23458@kroah.com> <200307162219.36290.gene.heskett@verizon.net> <20030717041037.GA4532@kroah.com>
In-Reply-To: <20030717041037.GA4532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307170547.03264.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [151.205.62.27] at Thu, 17 Jul 2003 04:47:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 July 2003 00:10, Greg KH wrote:
>On Wed, Jul 16, 2003 at 10:19:36PM -0400, Gene Heskett wrote:
>> So I repeat, something in that -pre5 to -pre6 patching of the usb
>> stuffs broke this.  Possibly even this patchset below.
>
>If you just back out the usb patches in -pre6 does it help?
>
>There is only 1 patch in here that might possibly be in code that
> you are hitting, the change to drivers/usb/usb.c  If you change
> that back, does it help?

I don't know, and likely won't try very soon as I just got back to the 
house from putting my wife in the shop, complications from emphesima.  
Long time 3 pack a day smoker, can't quit.

>I'd also really suggest asking the quick cam driver authors, as this
>driver isn't in the kernel tree so we have no idea what it could be
>doing.

My conversations with them haven't enlightened me, so I'm now waiting 
on a phone call from the SunPlus folks to see if I can obtain any 
data on the chipset in that camera, which is newer than what the 
qcam-vc folks had when they wrote that.

>thanks,
>
>greg k-h

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

