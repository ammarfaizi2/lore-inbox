Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVE0TbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVE0TbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVE0TbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:31:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43706
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262554AbVE0Tay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:30:54 -0400
Date: Fri, 27 May 2005 12:30:37 -0700 (PDT)
Message-Id: <20050527.123037.68041200.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       mchan@broadcom.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050527184750.GB11592@tuxdriver.com>
References: <04132005193844.8474@laptop>
	<20050421165956.55bdcb14.davem@davemloft.net>
	<20050527184750.GB11592@tuxdriver.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Fri, 27 May 2005 14:47:52 -0400

> Update pci.ids for BCM5752
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

I'll apply this, thanks John.

pci.ids needs several updates for tg3 in fact, and it
also now needs entries for bnx2 as well.
