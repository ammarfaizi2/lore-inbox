Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423857AbWKHW4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423857AbWKHW4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423859AbWKHW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:56:30 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:28688 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423857AbWKHW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:56:29 -0500
Date: Wed, 8 Nov 2006 22:56:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
Subject: Re: DMA APIs gumble grumble
Message-ID: <20061108225612.GA12345@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	linux-input@atrey.karlin.mff.cuni.cz,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Greg KH <greg@kroah.com>
References: <1162950877.28571.623.camel@localhost.localdomain> <20061108082536.GA3405@rhun.haifa.ibm.com> <1162975653.28571.723.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162975653.28571.723.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 07:47:33PM +1100, Benjamin Herrenschmidt wrote:
> Yes, I need multiple dma_ops for powerpc too

Ditto for ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
