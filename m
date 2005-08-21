Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVHUAOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVHUAOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 20:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVHUAOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 20:14:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28560
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750736AbVHUAOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 20:14:49 -0400
Date: Sat, 20 Aug 2005 17:14:46 -0700 (PDT)
Message-Id: <20050820.171446.105447223.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] net/core/sysctl_net_core.c: fix PROC_FS=n compile
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050820190309.GB3615@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<20050820190309.GB3615@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 20 Aug 2005 21:03:09 +0200

> This breaks the compilation with CONFIG_PROC_FS=n:
 ..
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
