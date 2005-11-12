Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVKLUZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVKLUZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKLUZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:25:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4880 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964774AbVKLUZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:25:45 -0500
Date: Sat, 12 Nov 2005 20:25:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix collie for -rc1
Message-ID: <20051112202538.GG28987@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051112202028.GA13617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051112202028.GA13617@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 09:20:28PM +0100, Pavel Machek wrote:
> This fixes compilation for collie after -rc1 platform_device
> changes. And yes, it even boots.

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
