Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965938AbWKIAoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965938AbWKIAoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965935AbWKIAoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:44:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:16590 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965938AbWKIAoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:44:10 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061108225612.GA12345@flint.arm.linux.org.uk>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061108082536.GA3405@rhun.haifa.ibm.com>
	 <1162975653.28571.723.camel@localhost.localdomain>
	 <20061108225612.GA12345@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 11:43:29 +1100
Message-Id: <1163033009.28571.785.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 22:56 +0000, Russell King wrote:
> On Wed, Nov 08, 2006 at 07:47:33PM +1100, Benjamin Herrenschmidt wrote:
> > Yes, I need multiple dma_ops for powerpc too
> 

Ok, I'm sending something under a new thread with a trimmed CC list for
the basic dev_sysdata bits. Look for [PATCH 0/2] Add dev_sysdata and use
it for ACPI

Cheers,
Ben

