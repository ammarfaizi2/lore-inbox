Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbULHRtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbULHRtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbULHRtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:49:04 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:41631 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261276AbULHRs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:48:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Mach Speed motherboard w/onboard video
Date: Wed, 8 Dec 2004 12:48:57 -0500
User-Agent: KMail/1.7
Cc: Lee Revell <rlrevell@joe-job.com>
References: <200412081140.33199.gene.heskett@verizon.net> <1102525014.30593.17.camel@krustophenia.net>
In-Reply-To: <1102525014.30593.17.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412081248.57255.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.76.102] at Wed, 8 Dec 2004 11:48:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 December 2004 11:56, Lee Revell wrote:
>On Wed, 2004-12-08 at 11:40 -0500, Gene Heskett wrote:
>> Has a builtin video, called UniCrome in the propaganda.
>>
>> Are there usable linux drivers for this one?
>
>Yes, they are quite good actually:
>
>http://unichrome.sourceforge.net/
>
>The biggest problem is that the via DRM module is not in the kernel
> yet. You will have to install it from dri.sourceforge.net CVS.  It
> was in a recent -mm release but was dropped and unfortunately the
> current version doesn't work with the -mm kernel.  Andrew Morton &
> others have said they will try to get it back in soon.
>
>Lee

Unforch, this implies its for 2.6 kernels.  The machine in question
will be running 2.5.25-adeos, an rtai conversion kernel.  I'll take a
look and see if it might be buildable for that.  Thanks for the links.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

