Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754531AbWKHLat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbWKHLat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbWKHLat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:30:49 -0500
Received: from www.osadl.org ([213.239.205.134]:30119 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754531AbWKHLas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:30:48 -0500
Subject: Re: 2.6.19-rc5: known regressions
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Komuro <komurojun-mbn@nifty.com>
In-Reply-To: <20061108085235.GT4729@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 12:32:58 +0100
Message-Id: <1162985578.8335.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 09:52 +0100, Adrian Bunk wrote:
> Subject    : SMP kernel can not generate ISA irq properly
> References : http://lkml.org/lkml/2006/10/22/15
> Submitter  : Komuro <komurojun-mbn@nifty.com>
> Handled-By : Thomas Gleixner <tglx@linutronix.de>
> Status     : Thomas is investigating

Problem is not reproducable on any of my boxen. 

Komuro, 

is this still happening on -rc5 ? If yes, can you please provide the
boot log with "apic=verbose" on the commandline ?

	tglx


