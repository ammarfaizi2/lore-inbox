Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDFFUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDFFUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 01:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWDFFUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 01:20:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16845
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932065AbWDFFUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 01:20:03 -0400
Date: Wed, 05 Apr 2006 22:19:57 -0700 (PDT)
Message-Id: <20060405.221957.47173834.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/core/net-sysfs.c: fix an off-by-21-or-49 error
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060404190742.GA6529@stusta.de>
References: <20060404190742.GA6529@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 4 Apr 2006 21:07:42 +0200

> This patch fixes an off-by-21-or-49 error ;-) spotted by the Coverity 
> checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
