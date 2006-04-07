Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWDGCJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWDGCJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 22:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWDGCJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 22:09:54 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:49110 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932285AbWDGCJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 22:09:53 -0400
Date: Thu, 06 Apr 2006 22:09:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [RFC: 2.6 patch] the overdue removal of
 RAW1394_REQ_ISO_{LISTEN,SEND}
In-reply-to: <200604062113.25147.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200604062209.52563.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060406224706.GD7118@stusta.de>
 <1144370417.15774.1.camel@mindpipe>
 <200604062113.25147.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 21:13, Gene Heskett wrote:
>On Thursday 06 April 2006 20:40, Lee Revell wrote:
>>On Thu, 2006-04-06 at 20:35 -0400, Gene Heskett wrote:
>>> On Thursday 06 April 2006 18:47, Adrian Bunk wrote:
>>> >This patch contains the overdue removal of the
>>> > RAW1394_REQ_ISO_SEND and RAW1394_REQ_ISO_LISTEN request types
>>> > plus all support code for them.
>>> >
>>> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>>
>>> NAK if my vote is worth $.02.  ieee1394 has been broken since
>>> 2.6.13-rc1, and apparently no one cares.  I have a firewire movie
>>> camera I haven't been able to use since then.  A Sony DVR-TVR460.
>>
>>I doubt this has anything to do with your problem.
>>
>>It is unfortunate that no one responded to your bug report.  Try
>> filing it in bugzilla.

I went to the 1394 site a few mnutes ago, and it has no link to 
bugzilla.  Which one were you referring to?

>Andrew fwd'd it to the 1394-devel list, but its since been swept under
>the rug.  Like the only one home is the receptionist or ??
>
>I'm watching that list, but its pretty dead.
>
>>Lee

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
