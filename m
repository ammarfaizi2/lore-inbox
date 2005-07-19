Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVGSVAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVGSVAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVGSVAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:00:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34517
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261705AbVGSVAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:00:43 -0400
Date: Tue, 19 Jul 2005 14:00:24 -0700 (PDT)
Message-Id: <20050719.140024.131914996.davem@davemloft.net>
To: bunk@stusta.de
Cc: shemminger@osdl.org, coreteam@netfilter.org,
       netfilter-devel@lists.netfilter.org, bridge@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] BRIDGE_EBT_ARPREPLY must depend on INET
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050719135529.GH5031@stusta.de>
References: <20050719135529.GH5031@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 19 Jul 2005 15:55:29 +0200

> BRIDGE_EBT_ARPREPLY=y and INET=n results in the following compile error:

Applied, thanks Adrian.
