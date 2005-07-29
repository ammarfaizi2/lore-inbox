Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVG2Dai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVG2Dai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVG2Da0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:30:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52937
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261552AbVG2DaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:30:24 -0400
Date: Thu, 28 Jul 2005 20:30:21 -0700 (PDT)
Message-Id: <20050728.203021.35467760.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baruch@ev-en.org
Subject: Re: [2.6 patch] net: Spelling mistakes threshoulds -> thresholds
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050728220410.GG4790@stusta.de>
References: <20050728220410.GG4790@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 29 Jul 2005 00:04:10 +0200

> Just simple spelling mistake fixes.
> 
> From: aruch Even <baruch@ev-en.org>
> 
> Signed-Off-By: Baruch Even <baruch@ev-en.org>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

The include/net/tcp.h part of this patch no longer
applies cleanly.
