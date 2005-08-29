Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVH2QSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVH2QSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVH2QSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:18:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3087 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751252AbVH2QSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:18:22 -0400
Date: Mon, 29 Aug 2005 17:18:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 04/16] I/O driver for 8250-compatible UARTs
Message-ID: <20050829171817.A15074@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <resend.3.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.3.2982005.trini@kernel.crashing.org> <resend.4.2982005.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <resend.4.2982005.trini@kernel.crashing.org>; from trini@kernel.crashing.org on Mon, Aug 29, 2005 at 09:09:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 09:09:37AM -0700, Tom Rini wrote:
> This is the I/O driver for any 8250-compatible UARTs.

Ah, obviously its patchbomb time.  2.6.13 must have been released! 8)

I wish for this stuff to wait until my queue of stuff has gone to
Linus first - otherwise Linus will probably have a merge headache
on his hands... unless these patches are against the -mm kernels.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
