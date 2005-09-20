Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVITP3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVITP3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVITP3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:29:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18953 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965037AbVITP3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:29:17 -0400
Date: Tue, 20 Sep 2005 16:29:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sean <seanlkml@sympatico.ca>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <20050920152904.GB493@flint.arm.linux.org.uk>
Mail-Followup-To: Sean <seanlkml@sympatico.ca>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org> <200509201005.49294.gene.heskett@verizon.net> <20050920141008.GA493@flint.arm.linux.org.uk> <200509201025.36998.gene.heskett@verizon.net> <56402.10.10.10.28.1127229646.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56402.10.10.10.28.1127229646.squirrel@linux1>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 11:20:46AM -0400, Sean wrote:
> On Tue, September 20, 2005 10:25 am, Gene Heskett said:
> 
> > Humm, what are they holding out for, more ram or more cpu?:-)
> >
> > FWIW, http://master.kernel.org doesn't show it either just now.
> 
> Gene,
> 
> While kernel.org snapshots will no doubt be working again shortly, you
> might want to consider using git.  It reduces the amount you have to
> download for each release a lot.

This doesn't help when the bots get stuck - neither the git repository
nor the ftp space get updated when this happens.  I believe both use
the same lock and are probably the same script.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
