Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTLKX4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbTLKX4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:56:05 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:41921 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S264429AbTLKX4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:56:02 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Matt Mackall <mpm@selenic.com>, inaky.perez-gonzalez@intel.com
Subject: Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Date: Thu, 11 Dec 2003 18:55:58 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
References: <0312030051..akdxcwbwbHdYdmdSaFbbcycyc3a~bzd25502@intel.com> <0312030051.paLaLbTdPdUbed6dXcEbXdDajbVdUd6c25502@intel.com> <20031211233031.GD23787@waste.org>
In-Reply-To: <20031211233031.GD23787@waste.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111855.58287.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.60.44] at Thu, 11 Dec 2003 17:56:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 18:30, Matt Mackall wrote:
>On Wed, Dec 03, 2003 at 12:51:34AM -0800, 
inaky.perez-gonzalez@intel.com wrote:
>>  include/linux/fuqueue.h |  451
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>> include/linux/plist.h   |  197 ++++++++++++++++++++
>>  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
>>  3 files changed, 868 insertions(+)
>>
>> +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003
>
>I don't suppose you've run this feature name past anyone in
> marketting or PR?

Obviously not...

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

