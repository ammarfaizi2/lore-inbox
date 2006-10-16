Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWJPUsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWJPUsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJPUsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:48:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22472
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161064AbWJPUsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:48:05 -0400
Date: Mon, 16 Oct 2006 13:48:06 -0700 (PDT)
Message-Id: <20061016.134806.104032792.davem@davemloft.net>
To: andrew@walrond.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
References: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: andrew@walrond.org
Date: Mon, 16 Oct 2006 14:11:27 +0000

> This is a Sun T1000 (6 cores / 24 threads) running a vanilla 2.6.18
> kernel. Everthing seems to be working OK, but this message appeared in
> the kernel log:

Turn of CONFIG_PROM_CONSOLE.

