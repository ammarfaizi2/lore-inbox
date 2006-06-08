Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWFHEVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWFHEVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 00:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWFHEVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 00:21:09 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:4063 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932497AbWFHEVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 00:21:08 -0400
Date: Thu, 8 Jun 2006 00:21:09 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, jamagallon@ono.com, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-ID: <20060608042109.GA6337@ccure.user-mode-linux.org>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060608003153.36f59e6a@werewolf.auna.net> <20060607154054.cf4f2512.akpm@osdl.org> <20060607162326.3d2cc76b.rdunlap@xenotime.net> <20060608021149.GA5567@ccure.user-mode-linux.org> <20060607193225.989add4c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607193225.989add4c.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 07:32:25PM -0700, Randy.Dunlap wrote:
> > make ARCH=um allmodconfig
> /var/linsrc/linux-2617-rc6mm1/arch/um/Makefile:113: *** missing separator.  Stop.
> 
> is that known/fixed?

No.  rc6-mm1 builds fine here.  I just checked with a fresh tree.

Are you sure you have a clean tree?

				Jeff
