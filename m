Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTKOKTu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 05:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTKOKTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 05:19:50 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:42914 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261552AbTKOKTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 05:19:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Sat, 15 Nov 2003 05:19:46 -0500
User-Agent: KMail/1.5.1
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
References: <20031114113224.GR21265@home.bofhlet.net> <200311141856.17275.gene.heskett@verizon.net> <873ccqvx9w.fsf@devron.myhome.or.jp>
In-Reply-To: <873ccqvx9w.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311150519.46091.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.12.17] at Sat, 15 Nov 2003 04:19:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 November 2003 03:41, OGAWA Hirofumi wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> On Friday 14 November 2003 15:02, OGAWA Hirofumi wrote:
>> >Gene Heskett <gene.heskett@verizon.net> writes:
>> >> dd if=/dev/sda1|md5sum <--note use of the same device as to
>> >> read pix. has been running for 3 or so minutes now, steadily
>> >> reading the camera. I shoulda put a time in front of it!  Ok
>> >> got it, heres the sum: 127945+0 records in
>> >> 127945+0 records out
>> >> f6c568dd1f35bb37f3d667a2ab228e2f
>> >> f6c568dd1f35bb37f3d667a2ab228e2f
>
>[...]
>
>> However, before I rebooted, those operations felt a solid as a
>> rock, and always returned the same md5sum on a repeat.
>
>Umm... is you talking about my request?

Yes.

Sorry for confusing.
>Let me start next step.

Please proceed.
>
>>> Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
>>> Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF
>>> (i_pos 0) Nov 14 09:20:34 coyote kernel:     File system has been
>>> set read-only
>
>I want to reproduce this on my machine. Can you reproduce this easy?

Apparently so, but I'd have to go out and waste a set of batteries 
loading the card up again, its presently empty.  However, I suspect 
you may have something else on your mind. :)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

