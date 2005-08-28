Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVH1Rau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVH1Rau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVH1Rau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:30:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7688 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750704AbVH1Rau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:30:50 -0400
Date: Sun, 28 Aug 2005 18:30:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] drop i386-isms from arm Kconfig
Message-ID: <20050828183042.B14294@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050822110427.GA9168@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050822110427.GA9168@elf.ucw.cz>; from pavel@ucw.cz on Mon, Aug 22, 2005 at 01:04:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:04:27PM +0200, Pavel Machek wrote:
> This kills i386-specific stuff from arm Kconfig. Please apply,

Could I have a signed-off-by line for this patch please?

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
