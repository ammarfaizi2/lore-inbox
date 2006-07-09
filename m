Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWGITNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWGITNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWGITNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:13:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31716
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161061AbWGITNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:13:02 -0400
Date: Sun, 09 Jul 2006 12:13:38 -0700 (PDT)
Message-Id: <20060709.121338.15426828.davem@davemloft.net>
To: bunk@stusta.de
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.n
Subject: Re: [2.6 patch] net/atm/clip.c: fix PROC_FS=n compile
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060708202000.GC5020@stusta.de>
References: <20060708202000.GC5020@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 8 Jul 2006 22:20:01 +0200

> This patch fixes the following compile error with CONFIG_PROC_FS=n by 
> reverting commit dcdb02752ff13a64433c36f2937a58d93ae7a19e:

Applied, thanks Adrian.
