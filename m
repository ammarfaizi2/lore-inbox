Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVB1QGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVB1QGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVB1QGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:06:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48392 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261666AbVB1QG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:06:29 -0500
Date: Mon, 28 Feb 2005 16:06:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] resend, 8250 woraround for buggy uart
Message-ID: <20050228160618.A22445@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1108500188.7373.46.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1108500188.7373.46.camel@tdi>; from alex.williamson@hp.com on Tue, Feb 15, 2005 at 01:43:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 01:43:08PM -0700, Alex Williamson wrote:
> Can we get this into the queue once 2.6.12 opens?

It's in the queue, and should be in the next -mm or post 2.6.11 which
ever is earlier.

Thanks for sorting this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
