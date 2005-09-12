Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVILOQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVILOQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVILOQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:16:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28179 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750981AbVILOQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:16:21 -0400
Date: Mon, 12 Sep 2005 15:16:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove trailing whitespace in wbsd
Message-ID: <20050912151616.A9407@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43249566.8050500@drzeus.cx> <43253305.9070508@drzeus.cx> <20050912105237.B23744@flint.arm.linux.org.uk> <4325615B.5090805@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4325615B.5090805@drzeus.cx>; from drzeus-list@drzeus.cx on Mon, Sep 12, 2005 at 01:07:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 01:07:07PM +0200, Pierre Ossman wrote:
> Russell King wrote:
> 
> >Unfortunately, this patch is white-space damaged, so doesn't apply.
> >I've tried fixing up the obvious stuff due to the wrapping, but I
> >still get:
> >
> >patching file drivers/mmc/wbsd.c
> >Hunk #14 FAILED at 363.
> >Hunk #82 FAILED at 1743.
> >
> >  
> >
> 
> Damn these wrapping mailers. I've attached the patch instead of inlining
> it so the mailer should leave it alone this time.

Thanks, that worked.  The other two probably need resending as well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
