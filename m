Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbUKDMXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbUKDMXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUKDMW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:22:26 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:21169 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262186AbUKDMTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:19:00 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 07:18:54 -0500
User-Agent: KMail/1.7
Cc: Jan Knutar <jk-lkml@sci.fi>, Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040657.10322.gene.heskett@verizon.net> <200411041412.42493.jk-lkml@sci.fi>
In-Reply-To: <200411041412.42493.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040718.54250.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.11.139] at Thu, 4 Nov 2004 06:18:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 07:12, Jan Knutar wrote:
>On Thursday 04 November 2004 13:57, Gene Heskett wrote:
>> I'e had that turned on since forever Jan, but usually, when its
>> hung someplace, its well and truely hung, and hardware reset
>> button time.
>
>Are you saying that these zombies (or tasks stuck in state D) also
> make sysrq-T hang, and not list all tasks?

The machine is hung.  No ssh, no ping response, the only button that 
works is the hardware reset on the front of the tower.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
