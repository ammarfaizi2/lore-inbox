Return-Path: <linux-kernel-owner+w=401wt.eu-S1030274AbXAECMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbXAECMG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbXAECMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:12:05 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:40087 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030275AbXAECME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:12:04 -0500
Date: Thu, 04 Jan 2007 21:11:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
In-reply-to: <459D7BC9.1050108@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: Ed Sweetman <safemode2@comcast.net>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Message-id: <200701042111.30384.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <459C5D6C.5010509@comcast.net>
 <200701040349.16650.s0348365@sms.ed.ac.uk> <459D7BC9.1050108@comcast.net>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2007 17:12, Ed Sweetman wrote:
>Alistair John Strachan wrote:
>> On Thursday 04 January 2007 01:50, Ed Sweetman wrote:
>>> Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in
>>> libata land but SMART is no longer available on my hdds.   I'm
>>> assuming this is not the intended behavior.
>>>
>>> In case this is chipset specific, IDE interface: nVidia Corporation
>>> CK804 Serial ATA Controller (rev f3)
>>>
>>> I'm using Libata nvidia driver, the drives happen to be sata drives,
>>> but even the pata ones no longer report having SMART.
>>
>> What program are you trying to use here? As I reported around -rc1
>> time, hddtemp is broken by 2.6.20-rc but Jens posted a patch to fix
>> it.
>
Which I believe must already be in -rc3.  I just started it after 
configuring it, restarted gkrellm and there they all were.  But I haven't 
tried any earlier kernels with it either.


>I must have missed that blurb.   hddtemp is indeed the program I was
>looking at.  And it does seem that it is the only one broken.  Just
>re-installed the other smartctl tools and they do work.  Thanks.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.
