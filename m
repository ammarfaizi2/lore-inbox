Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTJaBtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTJaBtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:49:51 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:36551 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262736AbTJaBtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:49:49 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: cliff white <cliffw@osdl.org>
Subject: Re: 2.6.0-test9 vs sound
Date: Thu, 30 Oct 2003 20:49:45 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200310301008.27871.gene.heskett@verizon.net> <20031030160719.76bee7f6.cliffw@osdl.org>
In-Reply-To: <20031030160719.76bee7f6.cliffw@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310302049.45009.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.58.154] at Thu, 30 Oct 2003 19:49:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 October 2003 19:07, cliff white wrote:
>On Thu, 30 Oct 2003 10:08:27 -0500
>
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> Where can I find a step by step tutorial on installing alsa since
>> OSS has been deprecated?  I've been using the shareware OSS on
>> this mobo for years, the audio chipset is VIA 8233 family.  I have
>> as much of it compiled into the kernel as there are checkmarks in
>> kconfig but nothing soundwise is working yet.  I also put that LXD
>> option on the grub line, but thats being ignored, the dmesg
>> comment is still there. If grub.conf wasn't where it goes, please
>> advise on that too.
>>
>> I've been booted to this for about 10 hours now, and so far sound
>> is the only thing not working that I've needed.  Not all of my usb
>> stuff has been exercized yet though.
>>
>> So far it just plain feels good, congrats to all involved.
>>
>> Mmm, the pair of warnings about the check_region call being
>> deprecated are still there in the advansys driver, but it worked
>> normally for amanda last night.
>
>I would start from the source:
>http://alsa-project.org/documentation.php3
>Or, try the Linux Audio Users Guide:
>
>http://www.djcj.org/LAU/guide/index.php
>
>A setup guide for the via8233, with module config info is here:
>
>http://alsa.opensrc.org/index.php?page=via8233
>
>cliffw
>
Ok thanks, followup Q:  Whats the version number thats in the kernel 
srcs?
The latest dl's available are version 9.8.
>> --
>> Cheers, Gene
>> AMD K6-III@500mhz 320M
>> Athlon1600XP@1400mhz  512M
>> 99.27% setiathome rank, not too shabby for a WV hillbilly
>> Yahoo.com attornies please note, additions to this message
>> by Gene Heskett are:
>> Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to
>> majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

