Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVK3A3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVK3A3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVK3A3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:29:25 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4225
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750718AbVK3A3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:29:24 -0500
Date: Tue, 29 Nov 2005 16:29:05 -0800 (PST)
Message-Id: <20051129.162905.100281236.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv6/: make two functions static
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051123012359.GH3963@stusta.de>
References: <20051123012359.GH3963@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Wed, 23 Nov 2005 02:23:59 +0100

> This patch makes two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Also applied, thanks.
