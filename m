Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTJ3WTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJ3WTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:19:08 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:20161 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262901AbTJ3WS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:18:57 -0500
Date: Thu, 30 Oct 2003 17:18:56 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] Fix PCMCIA card detection
In-Reply-To: <20031028212749.B31337@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0310301717340.10906@marabou.research.att.com>
References: <20031028212749.B31337@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003, Russell King wrote:

> I'm intending sending Linus the following patch to fix PCMCIA card
> detection about 24 hours (on 21:26 GMT on Oct 29th.)  A couple of
> people have tested it and reported that it fixes their card detection
> problems.  I'd like people _without_ this problem to try the patch
> and report if they see any breakages.

No problems for me.  2.6.0-test9-bk3 with the patch for IRQ routing on TI
bridges.

01:00.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)

-- 
Regards,
Pavel Roskin
