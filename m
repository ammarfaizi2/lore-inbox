Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVIBPVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVIBPVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVIBPVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:21:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13837 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750711AbVIBPVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:21:09 -0400
Date: Fri, 2 Sep 2005 16:21:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver (serial_core.c) status messages should be set to KERN_INFO
Message-ID: <20050902162104.A6546@flint.arm.linux.org.uk>
Mail-Followup-To: Alon Bar-Lev <alon.barlev@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43177223.8030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43177223.8030403@gmail.com>; from alon.barlev@gmail.com on Fri, Sep 02, 2005 at 12:26:59AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 12:26:59AM +0300, Alon Bar-Lev wrote:
> When upgrading to 2.6.13 I've noticed that serial driver reports it 
> status with unknown severity, causing the boot-splash to be overridden.

Please don't submit patches to bugzilla as a way to get them into the
kernel.  Instead, please send them direct to the person/mailing list
responsible for the area, as per the SubmittingPatches document in
the kernel tree.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
