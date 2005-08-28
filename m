Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVH1RR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVH1RR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVH1RR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:17:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19219 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750702AbVH1RR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:17:56 -0400
Date: Sun, 28 Aug 2005 18:17:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Documentation/arm/README: small update
Message-ID: <20050828181750.A14294@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050824103653.GI5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050824103653.GI5603@stusta.de>; from bunk@stusta.de on Wed, Aug 24, 2005 at 12:36:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 12:36:53PM +0200, Adrian Bunk wrote:
> - egcs is not supported by kernel 2.6

Ok.

> - Am I right to assume that gcc 2.95.3 is not worse than gcc 2.95.1?

No idea - I've given up tracking what compilers work and don't work on
the grounds that I'm too scared to change my compiler!  gcc 3.3 works
fine here which is the only version I use (until it's proven far too
buggy through local experience).

That probably means we should say "at least GCC 3.3" though I'm not
sure if that's entirely accurate.

Toolchains are just pure evil as far as stability on ARM goes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
