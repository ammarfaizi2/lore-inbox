Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVCSQGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVCSQGf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVCSQGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:06:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62736 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262578AbVCSQGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:06:31 -0500
Date: Sat, 19 Mar 2005 16:06:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new hp diva console port
Message-ID: <20050319160622.A23907@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1111163422.6693.6.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1111163422.6693.6.camel@tdi>; from alex.williamson@hp.com on Fri, Mar 18, 2005 at 09:30:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 09:30:22AM -0700, Alex Williamson wrote:
>    The patch below adds IDs and setup for a new PCI Diva console port.
> This device provides a single UART described by PCI Bar 1.  ID already
> submitted to pciids.sf.net.  Please apply.  Thanks,

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
