Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWFZMIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWFZMIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFZMIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:08:49 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:13549 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750807AbWFZMIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:08:48 -0400
Date: Mon, 26 Jun 2006 14:08:47 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chris Rankin <rankincj@yahoo.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.17: PMTimer results for another PCI chipset
Message-ID: <20060626120847.GA6272@rhlx01.fht-esslingen.de>
References: <20060623182237.GA19853@rhlx01.fht-esslingen.de> <20060625204212.29646.qmail@web52904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625204212.29646.qmail@web52904.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 25, 2006 at 09:42:12PM +0100, Chris Rankin wrote:
> Hi,
> 
> This motherboard / chipset runs the pmtimer_test application correctly as well. (PIII / UP).

Yeah, but this is no problem anyway, since it's neither in the blacklisted
nor in the graylisted area, IOW it's whitelisted and should work
without delays.
Or do you get the "The chipset may have PM-Timer Bug" message here??

> 00:1f.0 Class 0601: 8086:2440 (rev 05)

#define PCI_DEVICE_ID_INTEL_82801BA_0   0x2440

Thanks,

Andreas Mohr
