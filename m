Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbTGEVlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbTGEVlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:41:18 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27913 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266502AbTGEVlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:41:17 -0400
Date: Sat, 5 Jul 2003 23:51:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
Message-ID: <20030705235131.A10511@electric-eye.fr.zoreil.com>
References: <E19YtAq-0006Xf-00@calista.inka.de> <200307051637.52252.jeffpc@optonline.net> <3F0737D1.5090109@pobox.com> <200307051700.32533.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307051700.32533.jeffpc@optonline.net>; from jeffpc@optonline.net on Sat, Jul 05, 2003 at 04:59:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek <jeffpc@optonline.net> :
[network counter overflow on 32 bits systems]
> The thing is that x86 is here to stay for quite some time. Even if 64-bit 
> processors take over the market, you will have so many "old" computers that 
> can:
> 
> - - be thrown out
> - - donated to some institution
> - - converted to routers, and other "embedded" systems
> 
> Plus, they will be dirt cheap.

- the PCI bus don't/won't/can't handle multiple 10 Gb/s adapters;
- nobody sane would recycle x86 systems as core routers after having bought
  a few Gb/s link.

--
Ueimor
