Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVH1SW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVH1SW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 14:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVH1SW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 14:22:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52497 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750707AbVH1SW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 14:22:28 -0400
Date: Sun, 28 Aug 2005 19:22:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: ScytheBlade1 <scytheblade1@brantleyonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with MMC card reader
Message-ID: <20050828192222.E14294@flint.arm.linux.org.uk>
Mail-Followup-To: ScytheBlade1 <scytheblade1@brantleyonline.com>,
	linux-kernel@vger.kernel.org
References: <430AB13E.60609@brantleyonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <430AB13E.60609@brantleyonline.com>; from scytheblade1@brantleyonline.com on Mon, Aug 22, 2005 at 11:16:46PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 11:16:46PM -0600, ScytheBlade1 wrote:
> I've enabled everything needed...the CF port works flawlessly. However,
> the SD slot does *not*. I've got about 5+ pages worth of dmesg output
> related to this (MMC is NOT debug enabled, and I still get a disturbing
> amount of output). Would here be the best place to post this, or would a
> different list be better?

Since it seems to be a USB device, the USB mailing list could be an
appropriate place.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
