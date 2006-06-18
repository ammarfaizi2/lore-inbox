Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWFREHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWFREHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 00:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWFREHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 00:07:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4551
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932082AbWFREHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 00:07:47 -0400
Date: Sat, 17 Jun 2006 21:08:18 -0700 (PDT)
Message-Id: <20060617.210818.65908721.davem@davemloft.net>
To: mchan@broadcom.com
Cc: jk@blackdown.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: tg3 timeouts with 2.6.17-rc6
From: David Miller <davem@davemloft.net>
In-Reply-To: <1150568608.26368.49.camel@rh4>
References: <1551EAE59135BE47B544934E30FC4FC041BD1E@NT-IRVA-0751.brcm.ad.broadcom.com>
	<1150568608.26368.49.camel@rh4>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Sat, 17 Jun 2006 11:23:28 -0700

> David, Here's the patch if you haven't already made one:
> 
> [TG3]: Disable TSO by default on 5780 class chips.

Sorry, I didn't get a chance to push this into 2.6.17
in time.  I will push it into the first 2.6.17.x -stable
release.
