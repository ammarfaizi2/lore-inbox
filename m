Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWI3Dbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWI3Dbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 23:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWI3Dbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 23:31:32 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28816 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750716AbWI3Dbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 23:31:31 -0400
Date: Fri, 29 Sep 2006 21:30:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA status reports update
In-reply-to: <fa.BuZY3hsao85GkcEIgE6/7ZlG40A@ifi.uio.no>
To: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Prakash Punnoor <prakash@punnoor.de>
Message-id: <451DE4BF.70906@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.qX++qRit8w9OM0g1pdrG/oO2vt0@ifi.uio.no>
 <fa.Rp+FWnZ2aDKMZggJQPBaMZJIiTk@ifi.uio.no>
 <fa.mf96kUVw9JlcVmzGTV5ysiCiT3E@ifi.uio.no>
 <fa.qyxVQ/280iu/YZsbUzTDjAygfL4@ifi.uio.no>
 <fa.BuZY3hsao85GkcEIgE6/7ZlG40A@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Prakash Punnoor wrote:
>> Well, how would one debug it w/o hw docs? Or is it possible to compare 
>> the patch with a working driver for another chipset?
> 
> Well, it is based off of the standard ADMA[1] specification, albeit with 
> modifications.  There is pdc_adma.c, which is also based off ADMA.  And 
> the author (from NVIDIA) claims that the driver worked at one time, so 
> maybe it is simply bit rot that broke the driver.
> 
> If I knew the answer, it would be fixed, so the best answer 
> unfortunately is "who knows".
> 
> I wish I had the time.  But I also wish I had a team of programmers 
> working on libata, too ;-)

Do you know exactly what is allegedly broken in that version? I see that 
there are some functions which are just "TODO"..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

