Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVAJEv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVAJEv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 23:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVAJEv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 23:51:26 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:41213 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262070AbVAJEvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 23:51:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>
Subject: Re: starting with 2.7
Date: Sun, 9 Jan 2005 23:51:19 -0500
User-Agent: KMail/1.7
Cc: John Richard Moser <nigelenki@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, znmeb@cesmail.net
References: <1697129508.20050102210332@dns.toxicfilms.tv> <41E1CCB7.4030302@comcast.net> <21d7e99705010917281c6634b8@mail.gmail.com>
In-Reply-To: <21d7e99705010917281c6634b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501092351.19921.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.52.185] at Sun, 9 Jan 2005 22:51:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 20:28, Dave Airlie wrote:
>> And what 3rd party hardware vendor wants to waste their resources
>> by repeting smaller versions of the one-time cost of driver
>> writing over and over to accomodate linux, when they can't even
>> accomodate all versions due to special patches some people have? 
>> So far there's been a rediculous but visible trend of hardware
>> vendors to hold their source closed.
>
>I do wonder would open source kernel drivers to work with a closed
>source user space application be accepted into the mainline
> kernel... say for example Nvidia or VMware GPL'ed their lower layer
> kernel interfaces but kept their userspace (X driver and VMware)
> closed source which is perfectly acceptable from a license point of
> view.. would Linus/Andrew accept the nvidia lowlevel into the
> kernel, if not then it would be idealogical not licensing issues
> which would make the argument for having a stable module interface
> better :-)
>
>It would be interesting to find out .. and you are right there is
>little point in arguing this at this stage, closed source drivers
> are evil.
>
>Dave.

Are we not already seeing proprietary drivers in the form of hex code 
lists from these people with no srcs in the patches that have gone by 
on this list just this past week?  What makes these folks think the 
result won't be dissed and inspected?  I know I darned sure would be 
doing exactly that just to make sure the stuff is at least benign 
before its ever allowed in the same room with a production box...

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
