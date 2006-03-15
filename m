Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWCOBE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWCOBE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCOBE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:04:58 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18827
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932128AbWCOBE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:04:57 -0500
Date: Tue, 14 Mar 2006 17:04:48 -0800 (PST)
Message-Id: <20060314.170448.34817198.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [-mm patch] make drivers/net/tg3.c:tg3_request_irq()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060313212602.GL13973@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
	<20060313212602.GL13973@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 13 Mar 2006 22:26:02 +0100

> This patch makes the needlessly global function tg3_request_irq() 
> static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
