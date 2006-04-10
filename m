Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWDJF3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWDJF3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDJF3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:29:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43719
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750869AbWDJF3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:29:42 -0400
Date: Sun, 09 Apr 2006 22:29:26 -0700 (PDT)
Message-Id: <20060409.222926.61912446.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/random.c: unexport
 secure_ipv6_port_ephemeral
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060409155822.GI8454@stusta.de>
References: <20060409155822.GI8454@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 9 Apr 2006 17:58:22 +0200

> This patch removes the unused EXPORT_SYMBOL(secure_ipv6_port_ephemeral).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
