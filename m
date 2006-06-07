Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWFGS47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWFGS47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFGS46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:56:58 -0400
Received: from www.osadl.org ([213.239.205.134]:25302 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932353AbWFGS46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:56:58 -0400
Subject: Re: [patchset] Generic IRQ Subsystem: -V5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1149700829.5257.16.camel@localhost.localdomain>
References: <20060517001310.GA12877@elte.hu>
	 <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
	 <20060607165456.GC13165@flint.arm.linux.org.uk>
	 <1149700829.5257.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 20:57:30 +0200
Message-Id: <1149706650.5257.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 19:20 +0200, Thomas Gleixner wrote: 
> > Is there an updated series?  This doesn't apply to -rc6 - it seems
> > that maybe the ia64 folk merged some of the changes.
> 
> We did the latest changes against -mm. I can respin it against
> 2.6.16-rc6.

http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq1.patches.tar.bz2
http://www.tglx.de/projects/armirq/2.6.17-rc6/patch-2.6.17-rc6-armirq1.patch

	tglx


