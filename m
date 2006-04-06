Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWDFFVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDFFVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 01:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDFFVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 01:21:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17357
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932074AbWDFFVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 01:21:18 -0400
Date: Wed, 05 Apr 2006 22:21:18 -0700 (PDT)
Message-Id: <20060405.222118.17348215.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/tg3.c: fix a memory leak
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060404190935.GB6529@stusta.de>
References: <20060404190935.GB6529@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 4 Apr 2006 21:09:35 +0200

> This patch fixes a memory leak (buf wasn't freed) spotted by the 
> Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
