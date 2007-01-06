Return-Path: <linux-kernel-owner+w=401wt.eu-S1751051AbXAFB0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbXAFB0E (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbXAFB0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:26:04 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:43834 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbXAFB0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:26:03 -0500
Date: Fri, 05 Jan 2007 20:25:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: PL2303 module
In-reply-to: <20070106004552.GA6374@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Message-id: <200701052025.59620.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200612272248.06893.gene.heskett@verizon.net>
 <20070106004552.GA6374@kroah.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 19:45, Greg KH wrote:
>On Wed, Dec 27, 2006 at 10:48:06PM -0500, Gene Heskett wrote:
>> Greetings;
>>
>> Rather offtopic, but:
>>
>> Is there available anyplace, a document that describes how to
>> configure the PL2303 USB<->serial adaptor to match up with all the
>> hardware and flow control variations inherent in the basic rs-232
>> spec?
>
>It should work like any other serial port on Linux, so try the serial
>port programming HOWTO.

Maybe so Greg, but I spent quite some time on it a few months back, trying 
to make '7 wire' protocol work, could not.  I could type back and forth 
between terminal proggies, but an rzsz file transfer never got past the 
first packet.

But I'll take a look at those docs too, thanks.

>good luck,
>
>greg k-h
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
