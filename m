Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVL2IME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVL2IME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVL2IME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:12:04 -0500
Received: from math.ut.ee ([193.40.36.2]:3807 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932593AbVL2IMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:12:03 -0500
Date: Thu, 29 Dec 2005 10:11:45 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <20051228195509.GA12307@flint.arm.linux.org.uk>
Message-ID: <Pine.SOC.4.61.0512291011320.28176@math.ut.ee>
References: <20051214172445.GF7124@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512221231430.6200@math.ut.ee> <20051222130744.GA31339@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512231117560.25532@math.ut.ee> <20051223093343.GA22506@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512231204290.8311@math.ut.ee> <20051223104146.GB22506@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512271553480.7835@math.ut.ee> <20051228195509.GA12307@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can I assume that the bug has disappeared?  Does the patch make it
> disappear?

Yes, seems so.

-- 
Meelis Roos (mroos@linux.ee)
