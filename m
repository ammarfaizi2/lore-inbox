Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWFSVOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWFSVOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWFSVOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:14:14 -0400
Received: from www.osadl.org ([213.239.205.134]:64686 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964889AbWFSVON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:14:13 -0400
Subject: Re: [PATCH] ktime/hrtimer: fix kernel-doc comments
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hr
In-Reply-To: <20060619141127.abdfdac0.rdunlap@xenotime.net>
References: <20060619130948.6ea3998c.rdunlap@xenotime.net>
	 <1150750822.29299.86.camel@localhost.localdomain>
	 <20060619141127.abdfdac0.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 23:15:33 +0200
Message-Id: <1150751733.6780.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 14:11 -0700, Randy.Dunlap wrote:
> > My personal preference is to keep that line, as it makes it easier to
> > read. But as always: de gustibus non est disputandum :)
> 
> Feel free to send patches for scripts/kernel-doc instead.  :)

Yeah, Russell King pointed me to the nano-howto 2 minutes ago. Not
reading docs is always backfiring at some point. :(

Seriously, is it hard to fix ? I'm not good with perl, so its likely
that I would make more mess than fixups.

	tglx



