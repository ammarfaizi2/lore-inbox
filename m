Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUL0UY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUL0UY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUL0UY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:24:27 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:22737 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261976AbUL0UXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:23:54 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: bug: cd-rom autoclose no longer works in 2.6.9/2.6.10
Date: Mon, 27 Dec 2004 15:23:52 -0500
User-Agent: KMail/1.7
Cc: Stas Sergeev <stsp@aknet.ru>
References: <41D067AD.90607@aknet.ru>
In-Reply-To: <41D067AD.90607@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412271523.52505.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.45.252] at Mon, 27 Dec 2004 14:23:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 December 2004 14:51, Stas Sergeev wrote:
>Hello.
>
>Paul Ionescu wrote:
>> Does
>> cat /proc/sys/dev/cdrom/autoclose
>> return 1 or 0 ?
>
>[skip]
>
>>>/ $ cat /proc/sys/dev/cdrom/autoclose/
>>>/ 1/
>
>As explicitly written in my original
>post, it returns 1. And CD-ROM is capable
>of doing close either.

Mmm, k3b isn't haveing a problem with my lite-on, i burnt a fresh 
knoppix cd just last nighgt with 2.6.10.
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
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
