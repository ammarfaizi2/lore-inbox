Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbULNQZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbULNQZD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbULNQZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:25:02 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:63427 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261548AbULNQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:24:32 -0500
Message-ID: <41BF13EC.8020909@metaparadigm.com>
Date: Wed, 15 Dec 2004 00:25:16 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Sulmicki <adam@cfar.umd.edu>, Juergen Botz <jurgen@botz.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad T42, keyboard sometimes hosed when waking from sleep
References: <cpl6n2$ivd$1@sea.gmane.org> <Pine.BSF.4.61.0412131854030.66694@www.missl.cs.umd.edu>
In-Reply-To: <Pine.BSF.4.61.0412131854030.66694@www.missl.cs.umd.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sulmicki wrote:

>
>
> On Mon, 13 Dec 2004, Juergen Botz wrote:
>
>> I have a new IBM Thinkpad T42, FC3 with all updates, stock
>> 2.6.9-1.681_FC3 kernel + iwp2200 driver (0.13).  Everyone once
>> in a while when I wake from ACPI S3 sleep my keyboard is hosed...
>> the first key I press starts rapidly auto-repeating, which can't
>> be stopped, and pressing any key produces either no visible
>> action or some other character (not the one normally on that
>> key) which also auto repeats madly.
>>
>> It doesn't always happen, only maybe 10% of the time I come
>> out of S3.  I can't switch to different vt since ctrl-alt-fN
>> don't work, and since I am rarely on a text console I have
>> no idea whether it would happen there.  Putting the machine
>> back to sleep and re-waking doesn't fix it, so my only option
>> has been to reboot via the 'Actions' menu (mouse is ok through
>> all this.)
>>
>> Others have also reported this happening with APM, so it
>> doesn't seem to be an ACPI bug per se.
>>
>> Any ideas?
>
>
> just another data point. I had seen the same thing happen for me once 
> with my T41p. Same config as above ie FC3, 2.6.9-1.681_FC3.
>
> might be some RH-FC specific thing since I did not see it happen with 
> earlier incarnations of kernel.


I get the same thing on Debian/sid with pretty much stock 2.6.9
on a T42 - so probably not a RH-FC think - and I'm using APM.

~mc
