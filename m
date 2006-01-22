Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWAVAJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWAVAJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 19:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWAVAJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 19:09:17 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:9413 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751238AbWAVAJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 19:09:17 -0500
Date: Sat, 21 Jan 2006 19:09:15 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
In-reply-to: <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601211909.15559.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060119030251.GG19398@stusta.de>
 <200601211853.56339.gene.heskett@verizon.net>
 <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 January 2006 18:59, Doug McNaught wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>>>No, it's a different raw driver, for big databases that basically
>>> want their own custom filesystem on a disk.
>>
>> With the attendent possibility of rendering the whole thing
>> unrecoverably moot?
>>
>> OTOH, if this database actually does have a better way, and its
>> mature and proven, then I see no reason to cripple the database
>> people just to remove what is viewed as a potentially dangerous path
>> to the media surface for the unwashed to abuse.
>
>The database people have a newer and supported way to do that, via the
>O_DIRECT flag to open().  They aren't losing any functionality.
>
Good, but what about speed, is that impacted in any way they can 
measure, or is this flag/method actually faster than the raw driver is?

>-Doug

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
