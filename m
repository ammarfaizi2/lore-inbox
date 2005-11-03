Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVKCPaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVKCPaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVKCPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:30:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56590 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030298AbVKCPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:30:23 -0500
Date: Thu, 3 Nov 2005 15:30:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Message-ID: <20051103153017.GH28038@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <1131029686.18848.48.camel@localhost.localdomain> <20051103144830.GF28038@flint.arm.linux.org.uk> <1131033483.18848.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131033483.18848.71.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 03:58:03PM +0000, Alan Cox wrote:
> On Iau, 2005-11-03 at 14:48 +0000, Russell King wrote:
> > 
> > + icside ?
> > 
> 
> I've not really looked much outside of the PCI space yet (my first goal
> is to rescue the PC world and to get testing it wants x86 users) but
> Jeffs core libata code is strictly bus agnostic.

Ok, I look forward to fiddling with libata on ARM. 8)

You mentioned that libata doesn't do SWDMA - does it do MWDMA and PIO?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
