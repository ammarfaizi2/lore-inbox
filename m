Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWCIXKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWCIXKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCIXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:10:00 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44955
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750834AbWCIXJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:09:59 -0500
Date: Thu, 09 Mar 2006 15:09:45 -0800 (PST)
Message-Id: <20060309.150945.44837916.davem@davemloft.net>
To: bunk@stusta.de
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] tg3.c:tg3_bus_string(): remove dead code
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060309230650.GJ21864@stusta.de>
References: <20060309230650.GJ21864@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 10 Mar 2006 00:06:50 +0100

> The Coverity checker spotted this dead code (note that (clock_ctrl == 7) 
> is already handled above).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
