Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbUJ1XMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUJ1XMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUJ1XID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:08:03 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:61070 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262868AbUJ1XFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:05:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Date: Thu, 28 Oct 2004 19:05:20 -0400
User-Agent: KMail/1.7
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <41809921.10200@lbsd.net> <200410281432.01013.gene.heskett@verizon.net> <87zn261v1b.fsf@devron.myhome.or.jp>
In-Reply-To: <87zn261v1b.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281905.20547.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [141.153.91.102] at Thu, 28 Oct 2004 18:05:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 15:50, OGAWA Hirofumi wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> Now, how about its going read-only on me if I move (and delete)
>> say 33 pix at the head of the its directory listing?  Is this an
>> M$ related fs bug in the camera?
>>
>> Thats required some contortions like camera battery removal,
>> reboot this machine, etc to alleviate and restore normal
>> operations in the past.
>
>Umm... When filesystem became to read-only, is there the messages
> from kernel (output of dmesg)?

Not at the time, which is why I came to the conclusion it may be a bug 
in the camera software.  It checks in as version 1.0, and we all know 
no one trusts anything at version 1.0. :-)

I know now how to keep it from happening, so its not a showstopper for 
me.

Thanks OGAWA.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
