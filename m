Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTLGN4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTLGN4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:56:55 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:31144 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S264432AbTLGN4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:56:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Helge Hafting <helgehaf@aitel.hist.no>, jdow <jdow@earthlink.net>
Subject: Re: Large-FAT32-Filesystem Bug
Date: Sun, 7 Dec 2003 08:56:50 -0500
User-Agent: KMail/1.5.1
Cc: Torsten Scheck <torsten.scheck@gmx.de>, linux-kernel@vger.kernel.org
References: <3FD0555F.5060608@gmx.de> <005301c3bb32$11a041a0$1225a8c0@kittycat> <20031207122650.GA30938@hh.idb.hist.no>
In-Reply-To: <20031207122650.GA30938@hh.idb.hist.no>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312070856.50978.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.10.15] at Sun, 7 Dec 2003 07:56:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 07:26, Helge Hafting wrote:
>On Fri, Dec 05, 2003 at 05:17:00AM -0800, jdow wrote:
>> From: "Torsten Scheck" <torsten.scheck@gmx.de>
>>
>> > Dear friends:
>> >
>> > I already sent a message to the VFAT maintainer, but I decided
>> > to additionally bother this list with a warning. This way some
>> > readers might avoid data loss.
>>
>> This all may be moot. Microsoft is about to charge a royalty for
>> use of the FAT file system.
>> http://www.microsoft.com/mscorp/ip/tech/fat.asp
>
>The claim some patents, but aren't FAT so old that they have
>expired?

The patent is on the long filenames piece of vfat AIUI.  The older 
fat16/fat32 stuff isn't covered AFAIK.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

