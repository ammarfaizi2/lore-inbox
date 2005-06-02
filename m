Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFBURY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFBURY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFBULe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:11:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10632
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261313AbVFBUG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:06:58 -0400
Date: Thu, 02 Jun 2005 13:06:48 -0700 (PDT)
Message-Id: <20050602.130648.75428139.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [2.6 patch] net/ipv6/ipv6_syms.c: unexport fl6_sock_lookup
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050530205653.GZ10441@stusta.de>
References: <20050530205653.GZ10441@stusta.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 30 May 2005 22:56:53 +0200

> There is no usage of this EXPORT_SYMBOL in the kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Acked-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

Applied, thanks.
