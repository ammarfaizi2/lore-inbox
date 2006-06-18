Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWFRQrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWFRQrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWFRQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:47:16 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:65474 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S932249AbWFRQrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:47:15 -0400
Message-ID: <44958391.6050800@tomt.net>
Date: Sun, 18 Jun 2006 18:47:13 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060614)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, bcm43xx-dev@lists.berlios.de
Subject: Re: Linux v2.6.17
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <200606181254.13600.mb@bu3sch.de>
In-Reply-To: <200606181254.13600.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Sunday 18 June 2006 03:59, Linus Torvalds wrote:
>> Not a lot of changes since the last -rc, the bulk is actually some 
>> last-minute MIPS updates and s390 futex changes, the rest tend to be 
>> various very small fixes that trickled in over the last week.
> 
> D'oh, please queue the following patch for -stable, Greg. ;)

I'm unable to apply it on top a clean 2.6.17 using patch -p1 < mailfile.

Hunk #2 FAILED at 1900.
1 out of 2 hunks FAILED -- saving rejects to file 
drivers/net/wireless/bcm43xx/bcm43xx_main.c.rej
