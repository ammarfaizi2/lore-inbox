Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVLYOqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVLYOqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 09:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVLYOqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 09:46:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45257 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750835AbVLYOqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 09:46:51 -0500
Message-ID: <43AEB0CB.20403@pobox.com>
Date: Sun, 25 Dec 2005 09:46:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
CC: Mark Lord <lkml@rtr.ca>, Justin Piszcz <jpiszcz@lucidpixels.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
References: <Pine.LNX.4.64.0512241830010.2700@p34> <43ADDD34.9020101@rtr.ca> <200512250937.55140.edt@aei.ca>
In-Reply-To: <200512250937.55140.edt@aei.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.5 (+)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ed Tomlinson wrote: > On Saturday 24 December 2005
	18:43, Mark Lord wrote: > >> >smartmontools is going to have to be
	updated >> >>What for? >> >>Use "smartctl -d ata /dev/sda" > > > Its
	not perfect: > > grover:/poola/home/ed# smartctl -d ata /dev/sda >
	smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5
	Bruce Allen > Home page is http://smartmontools.sourceforge.net/ > >
	smartctl has problems but hddtemp works [...] 
	Content analysis details:   (1.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.3 GAPPY_SUBJECT          Subject: contains G.a.p.p.y-T.e.x.t
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> On Saturday 24 December 2005 18:43, Mark Lord wrote:
> 
>> >smartmontools is going to have to be updated
>>
>>What for?
>>
>>Use "smartctl -d ata /dev/sda"
> 
> 
> Its not perfect:
> 
> grover:/poola/home/ed# smartctl -d ata /dev/sda
> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> smartctl has problems but hddtemp works

What are the problems?  Your output gives us no clue...

	Jeff



