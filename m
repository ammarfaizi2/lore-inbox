Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbTGMODP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbTGMODP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:03:15 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:44223 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S267818AbTGMODN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:03:13 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Riley Williams" <Riley@Williams.Name>,
       "David Ford" <david+powerix@blue-labs.org>,
       "Ryan Underwood" <nemesis-lists@icequake.net>
Subject: Re: Forking shell bombs
Date: Sun, 13 Jul 2003 10:17:56 -0400
User-Agent: KMail/1.5.1
Cc: <linux-kernel@vger.kernel.org>
References: <BKEGKPICNAKILKJKMHCAOELCENAA.Riley@Williams.Name>
In-Reply-To: <BKEGKPICNAKILKJKMHCAOELCENAA.Riley@Williams.Name>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131017.56814.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.27] at Sun, 13 Jul 2003 09:17:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 July 2003 05:10, Riley Williams wrote:
>Hi all.
>
>It sounds like what is required is some way of basically saying
>"Don't permit new processes to be created if CPU usage > 75%"
>(where the 75% is configurable but less than 100%).
>
Which would immediately cause problems for anyone running setiathome.  
My cpu useage has been 100% for 5 years.

>Best wishes from Riley.
>---
> * Nothing as pretty as a smile, nothing as ugly as a frown.
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of David
> > Ford Sent: Wednesday, July 09, 2003 4:08 PM
> > To: Ryan Underwood
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: Forking shell bombs
> >
> > No such thing exists.  I can have 10,000 processes doing nothing
> > and have a load average of 0.00.  I can have 100 processes each
> > sucking cpu as fast as the electrons flow and have a dead box.
> >
> > Learn how to manage resource limits and you can tuck another
> > feather into your fledgeling sysadmin hat ;)
> >
> > david
> >
> > Ryan Underwood wrote:
> >> Hi,
> >>
> >> On Tue, Jul 08, 2003 at 04:43:18PM -0400, jhigdon wrote:
> >>> Have you tried this on any 2.5.x kernels? Just curious to see
> >>> what it does, I plan on giving it a go later.
> >>
> >> I haven't, but a previous poster indicated that they had
> >> (2.5.74) with the same results.
> >>
> >> I wonder if we could find an upper limit on the number of
> >> allowable processes that would leave the box in a workable
> >> state?  Unfortunately, I don't have a spare box to test such
> >> things on at the moment. ;)
> >>
> >> Thanks,
>
>---
>Outgoing mail is certified Virus Free.
>Checked by AVG anti-virus system (http://www.grisoft.com).
>Version: 6.0.500 / Virus Database: 298 - Release Date: 10-Jul-2003
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

