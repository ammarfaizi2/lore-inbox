Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTFEB5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFEB5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:57:07 -0400
Received: from imsantv21.netvigator.com ([210.87.250.77]:31165 "EHLO
	imsantv21.netvigator.com") by vger.kernel.org with ESMTP
	id S264370AbTFEB5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:57:03 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Pavel Machek <pavel@suse.cz>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Linux 2.4.21-rc6
Date: Thu, 5 Jun 2003 10:10:01 +0800
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>,
       lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <200306031813.10155.m.c.p@wolk-project.de> <20030604215431.GJ333@elf.ucw.cz>
In-Reply-To: <20030604215431.GJ333@elf.ucw.cz>
X-OS: GNU/Linux+KDE
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306051010.01649.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 June 2003 05:54, Pavel Machek wrote:
> Hi!
>
> > > Ok, so you can reproduce the hangs reliably EVEN with -rc6, Marc?
> >
> > well, even if you mean Marc Wilson, I also have to say something (as I've
> > written in my previous email some days ago)
> >
> > The pauses/stops are _a lot_ less than w/o the fix but they are _not_
> > gone. Tested with 2.4.21-rc6.
>
> If hangs are not worse than 2.4.20, then I'd go ahead with release....
>
> 									
I have -rc6 running on a P4 for a few days, doing the test script, 
compiles, Opera and found it to be comparable to 2.4.18.

It also does well on slower machines of about 1/4 the the CPU and disk
bandwidth. 

IMHO, interactivity is reasonable (again just IMHO), and others
may disagree.

-- 
Powered by linux-2.5.70-mm3
My current linux related activities in rough order of priority:
- Testing of 2.4/2.5 kernel interactivity
- Testing of Swsusp for 2.4
- Testing of Opera 7.11 emphasizing interactivity
- Research of NFS i/o errors during transfer 2.4>2.5
- Learning 2.5 series kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 series serial and ide drivers, ACPI, S3
* Input and feedback is always welcome *

