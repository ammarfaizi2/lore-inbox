Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUKDN4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUKDN4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbUKDN4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:56:23 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:27317 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262217AbUKDN4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:56:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 08:56:18 -0500
User-Agent: KMail/1.7
Cc: Jan Knutar <jk-lkml@sci.fi>, Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040718.54250.gene.heskett@verizon.net> <200411041429.51575.jk-lkml@sci.fi>
In-Reply-To: <200411041429.51575.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040856.18929.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.11.139] at Thu, 4 Nov 2004 07:56:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 07:29, Jan Knutar wrote:
>On Thursday 04 November 2004 14:18, Gene Heskett wrote:
>> The machine is hung.  No ssh, no ping response, the only button
>> that works is the hardware reset on the front of the tower.
>
>I must've missed where the thread went from zombies into totally
> hung machine. My apologies for the noise.

It went from an unkillable process (gnomeradio) that was blocking 
other programs like tvtime with its locks on /dev/video0, to 
completely hung at "stopping alsasound" when I tried to reboot.  That 
required the reset button to get going again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
