Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbUJ1ScZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbUJ1ScZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUJ1ScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:32:17 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:26572 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262880AbUJ1ScC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:32:02 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Date: Thu, 28 Oct 2004 14:32:00 -0400
User-Agent: KMail/1.7
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <41809921.10200@lbsd.net> <200410280812.41150.gene.heskett@verizon.net> <87oeingerg.fsf@devron.myhome.or.jp>
In-Reply-To: <87oeingerg.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281432.01013.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.153.91.102] at Thu, 28 Oct 2004 13:32:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 09:21, OGAWA Hirofumi wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> After the reboot to a 2.6.10-rc1-bk6 plus your patch, its still
>> fine, and except for the usual references to /dev/sda1 in the log
>> when I turn it on or off, mounting it and scanning its directory
>> doesn't generate any additional log info.  Was it supposed to?
>
>This bug is triggered by race condition. So, it may not happen.
>
>Thanks.

I see.  Apparently my lashup doesn't trigger it.

Now, how about its going read-only on me if I move (and delete) say 33 
pix at the head of the its directory listing?  Is this an M$ related 
fs bug in the camera?

Thats required some contortions like camera battery removal, reboot 
this machine, etc to alleviate and restore normal operations in the 
past.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
