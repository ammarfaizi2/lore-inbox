Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVCNUTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVCNUTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVCNUTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:19:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53126 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261832AbVCNUT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:19:26 -0500
Date: Mon, 14 Mar 2005 13:19:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-final-V0.7.40-00
Message-ID: <20050314201918.GG8345@smtp.west.cox.net>
References: <20050204100347.GA13186@elte.hu> <20050311092847.GA17855@elte.hu> <200503111210.52147.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503111210.52147.andrew@walrond.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 12:10:52PM +0000, Andrew Walrond wrote:
> On Friday 11 March 2005 09:28, Ingo Molnar wrote:
> > i have released the -V0.7.40-00 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> >
> 
> I've lost the thread a little; Is this still x86 only?

The patch itself contains i386, x86_64 and MIPS support.  There's been
patches posted for ARM (I _think_ one version which had a stab at
generic hardirq support for ARM and another without, and I kinda-sorta
think Ingo was waiting for the generic hardirq stuff to settle, which is
another issue) as well a PPC32.

-- 
Tom Rini
http://gate.crashing.org/~trini/
