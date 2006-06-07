Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWFGQzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWFGQzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFGQzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:55:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932335AbWFGQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:55:05 -0400
Date: Wed, 7 Jun 2006 17:54:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patchset] Generic IRQ Subsystem: -V5
Message-ID: <20060607165456.GC13165@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060517001310.GA12877@elte.hu> <20060517221536.GA13444@elte.hu> <20060519145225.GA12703@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519145225.GA12703@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 04:52:25PM +0200, Ingo Molnar wrote:
> This is Version 5 of the genirq patch-queue, against 2.6.17-rc4. The 
> genirq patch-queue improves the generic IRQ layer to be truly generic, 
> by adding various abstractions and features to it, without impacting 
> existing functionality. It converts ARM, i386 and x86_64 to this new 
> generic IRQ layer - while keeping compatibility with all the other 
> genirq architectures too.
> 
> The full patch-queue can be downloaded from:
> 
>   http://redhat.com/~mingo/generic-irq-subsystem/

Is there an updated series?  This doesn't apply to -rc6 - it seems
that maybe the ia64 folk merged some of the changes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
