Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWB1UpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWB1UpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWB1UpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:45:21 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41346
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932477AbWB1UpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:45:20 -0500
Date: Tue, 28 Feb 2006 12:45:15 -0800 (PST)
Message-Id: <20060228.124515.90095330.davem@davemloft.net>
To: lcapitulino@mandriva.com.br
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: Re: [PATCH 0/6] pktgen: refinements and small fixes (V3).
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060225160734.020bba3b@home.brethil>
References: <20060225160734.020bba3b@home.brethil>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Date: Sat, 25 Feb 2006 16:07:34 -0300

>  As you've asked, I'm sending again my patches for pktgen:
> 
> [PATCH 1/6] pktgen: Lindent run.
> [PATCH 2/6] pktgen: Ports thread list to Kernel list implementation.
> [PATCH 3/6] pktgen: Fix kernel_thread() fail leak.
> [PATCH 4/6] pktgen: Fix Initialization fail leak.
> [PATCH 5/6] pktgen: Ports if_list to the in-kernel implementation.
> [PATCH 6/6] pktgen: Updates version.

All applied, thanks a lot Luiz.
