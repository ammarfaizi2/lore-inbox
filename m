Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVL1TzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVL1TzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVL1TzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:55:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39433 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964892AbVL1TzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:55:18 -0500
Date: Wed, 28 Dec 2005 19:55:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051228195509.GA12307@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20051214172445.GF7124@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512221231430.6200@math.ut.ee> <20051222130744.GA31339@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231117560.25532@math.ut.ee> <20051223093343.GA22506@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231204290.8311@math.ut.ee> <20051223104146.GB22506@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512271553480.7835@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0512271553480.7835@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 03:54:29PM +0200, Meelis Roos wrote:
> >Right, discard all the patches I sent previously and use this one.
> 
> No messages at all so far, with several serial sessions.

Can I assume that the bug has disappeared?  Does the patch make it
disappear?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
