Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWFZG60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWFZG60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWFZG60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:58:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20123
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751193AbWFZG6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:58:25 -0400
Date: Sun, 25 Jun 2006 23:58:24 -0700 (PDT)
Message-Id: <20060625.235824.97292998.davem@davemloft.net>
To: bunk@stusta.de
Cc: herbert@gondor.apana.org.au, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make net/core/dev.c:netdev_nit static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060625231327.GL23314@stusta.de>
References: <20060625231327.GL23314@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 26 Jun 2006 01:13:27 +0200

> netdev_nit can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
