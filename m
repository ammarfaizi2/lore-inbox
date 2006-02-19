Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWBSUgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWBSUgS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWBSUgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:36:17 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:51955 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932111AbWBSUgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:36:17 -0500
Date: Sun, 19 Feb 2006 15:36:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: don't bother users with unimportant messages.
In-reply-to: <20060219175745.GB2674@kroah.com>
To: linux-kernel@vger.kernel.org
Message-id: <200602191536.16119.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060219010910.GA18841@redhat.com>
 <20060219082916.GA19903@redhat.com> <20060219175745.GB2674@kroah.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 12:57, Greg KH wrote:
>On Sun, Feb 19, 2006 at 03:29:16AM -0500, Dave Jones wrote:
>> On Sun, Feb 19, 2006 at 08:15:23AM +0000, Russell King wrote:
>>  > On Sat, Feb 18, 2006 at 08:09:10PM -0500, Dave Jones wrote:
>>  > > When users see these printed to the console, they think
>>  > > something is wrong.  As it's just informational and something
>>  > > that only developers care about, lower the printk level.
>>  >
>>  > If you're getting complaints about this, wouldn't it be better to
>>  > forward them here so that they can be fixed up?
>>
>> w83627hf, and probably other drivers from drivers/hwmon/
>
>With 2.6.16-rc4?  I thought I just sent a patch in for -rc3 to fix
> this.
>
It must be in rc4 Greg, I didn't see that error on the rc4 bootup.

>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
