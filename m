Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268071AbUGWVRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268071AbUGWVRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUGWVRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:17:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268071AbUGWVRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:17:18 -0400
Date: Fri, 23 Jul 2004 22:17:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC]: CONFIG_UNSUPPORTED (was: Re: [PATCH] delete devfs)
Message-ID: <20040723221713.A20752@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	"R. J. Wysocki" <rjwysocki@sisk.pl>, linux-kernel@vger.kernel.org
References: <20040721141524.GA12564@kroah.com> <20040722064952.GC20561@kroah.com> <20040722091335.A17187@home.com> <200407232106.41065.rjwysocki@sisk.pl> <20040723200416.GO19329@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040723200416.GO19329@fs.tum.de>; from bunk@fs.tum.de on Fri, Jul 23, 2004 at 10:04:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 10:04:17PM +0200, Adrian Bunk wrote:
> Quoting 2.6 MAINTAINERS:
> 
> <--  snip  -->
> 
> PCMCIA SUBSYSTEM
> L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
> S:      Unmaintained
> 
> <--  snip  -->

Not entirely true - it is "looked after" but not specifically maintained.
I'm happy to act as a patch collection service for it, and do certain
development on it, but I have enough to handle without having to
diagnose every guys laptop problems. 8)

I guess I should find a better way to express this in my sig as well!

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
