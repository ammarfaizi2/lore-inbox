Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVLUPYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVLUPYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLUPYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:24:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9484 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932409AbVLUPYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:24:19 -0500
Date: Wed, 21 Dec 2005 15:24:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051221152411.GF1736@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512142042570.16591@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0512142042570.16591@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:43:27PM +0200, Meelis Roos wrote:
> >Hmm, possibly, but could you apply this patch and provide the resulting
> >messages please?  It'll probably cause some character loss when it
> >decides to dump some debugging.
> 
> Not before friday unfortunately, but I will try then.

Any news?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
