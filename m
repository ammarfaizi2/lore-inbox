Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTKNX40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTKNX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 18:56:26 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:23274 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261168AbTKNX4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 18:56:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 18:56:17 -0500
User-Agent: KMail/1.5.1
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
References: <20031114113224.GR21265@home.bofhlet.net> <200311141351.18944.gene.heskett@verizon.net> <87ptfura5a.fsf@devron.myhome.or.jp>
In-Reply-To: <87ptfura5a.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141856.17275.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 17:56:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 15:02, OGAWA Hirofumi wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> dd if=/dev/sda1|md5sum <--note use of the same device as to read
>> pix. has been running for 3 or so minutes now, steadily reading
>> the camera. I shoulda put a time in front of it!  Ok got it, heres
>> the sum: 127945+0 records in
>> 127945+0 records out
>> f6c568dd1f35bb37f3d667a2ab228e2f
>> f6c568dd1f35bb37f3d667a2ab228e2f
>
>[...]
>
>> What does this tell us?
>
>Thanks. I want to know it's not reading the randomly garbage.
>Can this problem reproduce easy? If so, what operations?

NDI OGAWA.  And I rebooted to find that all my printers I had defined 
in cups were gone, and I cannot define new ones, getting 
sever-error-internal-error when I try.  And thats much more important 
to me ATM, sorry.

However, before I rebooted, those operations felt a solid as a rock, 
and always returned the same md5sum on a repeat.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

