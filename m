Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTK3J3v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTK3J3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:29:51 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:65196 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id S262315AbTK3J3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:29:50 -0500
Date: Sun, 30 Nov 2003 10:28:30 +0100
From: Eduard Bloch <edi@gmx.de>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Message-ID: <20031130092830.GA11942@zombie.inka.de>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com> <20031123204532.GA6093@zombie.inka.de> <1069654747.2812.689.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069654747.2812.689.camel@dhcppc4>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Len Brown [Mon, Nov 24 2003, 01:19:07AM]:

> > #include <hallo.h>
> > * Brown, Len [Sun, Nov 23 2003, 03:16:11PM]:
> > > > weird 1+2xHT mode.
> 
> Please try CONFIG_NR_CPUS=8, or apply the patch below to 2.4.23.

The first thing fixed the problem, thank you.

MfG,
Eduard.
-- 
Es ereignet sich nichts Neues. Es sind immer dieselben alten
Geschichten, die von immer neuen Menschen erlebt werden.
		-- William Faulkner
