Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVKOFmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVKOFmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKOFmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:42:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36588
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751331AbVKOFms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:42:48 -0500
Date: Mon, 14 Nov 2005 21:42:55 -0800 (PST)
Message-Id: <20051114.214255.15845939.davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: yanzheng@21cn.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]IPv6: small fix for ipv6_dev_get_saddr(...)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051115.102237.101993116.yoshfuji@linux-ipv6.org>
References: <43786A16.9070100@21cn.com>
	<20051115.102237.101993116.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Tue, 15 Nov 2005 10:22:37 +0900 (JST)

> In article <43786A16.9070100@21cn.com> (at Mon, 14 Nov 2005 18:42:30 +0800), Yan Zheng <yanzheng@21cn.com> says:
> 
> > The "score.rule++" doesn't make any sense for me. 
> > According to codes above, I think it should be "hiscore.rule++;" .
> 
> Oops, you're right.
> 
> > Signed-off-by: Yan Zheng<yanzheng@21cn.com>
> Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Applied.
