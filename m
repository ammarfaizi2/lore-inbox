Return-Path: <linux-kernel-owner+w=401wt.eu-S932846AbXASWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbXASWxy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXASWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 17:53:53 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:50229 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXASWxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 17:53:53 -0500
Date: Fri, 19 Jan 2007 17:53:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Probably wrong place to ask
In-reply-to: <45B136A0.3030503@tmr.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Davidsen <davidsen@tmr.com>
Message-id: <200701191753.42527.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200701191457.46798.gene.heskett@verizon.net>
 <45B136A0.3030503@tmr.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2007 16:22, Bill Davidsen wrote:
>Gene Heskett wrote:
>> Greetings all;
>>
>> I have a card reader plugged into a usb port.  I recognizes a 512meg
>> pny cf card just fine, but wwhen I plug in a 256meg Lexar cf, the led
>> comes on, but there is no reaction from linux. /dev/sda is not
>> created, nothing.
>>
>> Is this a kernel config problem, or is this particular cf known to be
>> a bad bird?
>
>I do that with CF and memory stick, what kernel, distribution, etc? I
>would suspect something in hotplug not noticing.
>
>I presume you have tried this from cold boot, so any issues with
>unplugging and plugging another flash are removed.

No I didn't try that.  See the other ignore me message for the answer.

Thanks Bill.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.
