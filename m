Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUEBOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUEBOwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUEBOwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 10:52:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24593 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263375AbUEBOw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 10:52:29 -0400
Date: Sun, 2 May 2004 15:52:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 1/4 MMC layer
Message-ID: <20040502155226.B17905@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040429134824.C16407@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429134824.C16407@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Apr 29, 2004 at 01:48:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:48:24PM +0100, Russell King wrote:
> This patch adds core support to the Linux kernel for driving MMC
> interfaces found on embedded devices, such as found in the Intel
> PXA and ARM MMCI primecell.  This patch does _not_ add support
> for SD or SDIO cards.

As there haven't been any comments, can I assume that either people
don't care, or people are happy for this to appear in Linus' tree?

(I actually suspect its out of peoples minds having been buried by
about 4 days of lkml.)

Thanks.  8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
