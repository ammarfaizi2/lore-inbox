Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUJNOWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUJNOWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUJNOWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:22:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265144AbUJNOWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:22:08 -0400
Message-ID: <416E8B7F.9050401@pobox.com>
Date: Thu, 14 Oct 2004 10:21:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hirokazu Takata <takata.hirokazu@renesas.com>, takata@linux-m32r.org,
       linux-kernel@vger.kernel.org, paul.mundt@nokia.com, nico@cam.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
References: <416BFD79.1010306@pobox.com>	<20041013.105243.511706221.takata.hirokazu@renesas.com>	<416C8E0B.4030409@pobox.com>	<20041013.121547.863739114.takata.hirokazu@renesas.com> <20041012223227.45a62301.akpm@osdl.org>
In-Reply-To: <20041012223227.45a62301.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> smc91x-revert-11923358-m32r-modify-drivers-net-smc91xc.patch
> smc91x-assorted-minor-cleanups.patch
> smc91x-set-the-mac-addr-from-the-smc_enable-function.patch
> smc91x-fold-smc_setmulticast-into-smc_set_multicast_list.patch
> smc91x-simplify-register-bank-usage.patch
> smc91x-move-tx-processing-out-of-irq-context-entirely.patch
> smc91x-use-a-work-queue-to-reconfigure-the-phy-from.patch
> smc91x-fix-possible-leak-of-the-skb-waiting-for-mem.patch
> smc91x-display-pertinent-register-values-from-the.patch
> smc91x-straighten-smp-locking.patch
> smc91x-cosmetics.patch
> m32r-trivial-fix-of-smc91xh.patch
> smc91x-fix-smp-lock-usage.patch
> smc91x-more-smp-locking-fixes.patch
> smc91x-fix-compilation-with-dma-on-pxa2xx.patch
> smc91x-receives-two-bytes-too-many.patch
> smc91x-release-on-chip-rx-packet-memory-asap.patch
> 
> I'll unload all those onto Jeff...


I'll wait for these patches, and drop other smc91x patches...

	Jeff


