Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSFRBL3>; Mon, 17 Jun 2002 21:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSFRBL2>; Mon, 17 Jun 2002 21:11:28 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:63730 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317211AbSFRBL2>;
	Mon, 17 Jun 2002 21:11:28 -0400
Date: Mon, 17 Jun 2002 18:11:28 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] : ir250_cache_wait_data-2.diff
Message-ID: <20020617181128.F6338@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020610175300.E21783@bougret.hpl.hp.com> <3D0A7219.6000303@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0A7219.6000303@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jun 14, 2002 at 06:45:45PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 06:45:45PM -0400, Jeff Garzik wrote:
> Patch did not apply...  I think you're a victim of __FUNCTION__ 
> cleanups, possibly.  Whoever did those in recent 2.5.x kernels didn't 
> bother notifying any maintainers :(

	By the way, is there any more cleanups in the pipeline ? I
mean, the whitespace cleanups missed 50% of the code and the
__FUNCTION__ cleanups missed 90% of the occurences, so should I expect
more or can I redo my patches this week ?
	Thanks...

	Jean
