Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUHEOSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUHEOSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUHEOQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:16:51 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:15493 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S267725AbUHEOOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:14:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 10:14:38 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040805004402.GA6304@cox.net> <200408051135.58125.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408051135.58125.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408051014.38202.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.11.172] at Thu, 5 Aug 2004 09:14:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 04:35, Denis Vlasenko wrote:
>
>Let's rule out PREEMPT first
>
>> 	Sorry I can't be more helpful.  Good luck.
>
>Maybe turn PREEMPT back on?

I found it was on when I checked last night, and turned it off for 
this build.  About 9 hours uptime now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
