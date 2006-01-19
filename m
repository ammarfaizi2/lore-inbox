Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWASBGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWASBGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWASBGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:06:05 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60644
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161131AbWASBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:06:03 -0500
Date: Wed, 18 Jan 2006 17:05:54 -0800 (PST)
Message-Id: <20060118.170554.72421916.davem@davemloft.net>
To: arnd@arndb.de
Cc: spereira@tusc.com.au, yoshfuji@linux-ipv6.org, acme@ghostprotocols.net,
       ak@muc.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       pereira.shaun@gmail.com
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200601190157.38277.arnd@arndb.de>
References: <200601170115.07019.arnd@arndb.de>
	<1137567396.14130.2.camel@spereira05.tusc.com.au>
	<200601190157.38277.arnd@arndb.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Jan 2006 01:57:37 +0100

> I'm not that familiar with the process for non-driver patches for
> netdev (nor for device drivers as it seems ;-)), but my
> understanding is that you should address those to Jeff Garzik as
> well, asking for inclusion in the netdev-2.6 git tree in your
> introductory '[PATCH 0/4]' mail.

Those should be CC:'d to me, not Jeff, he has enough to review
and merge :)
