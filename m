Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRF2E03>; Fri, 29 Jun 2001 00:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264259AbRF2E0S>; Fri, 29 Jun 2001 00:26:18 -0400
Received: from renoir.op.net ([207.29.195.4]:11782 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S262614AbRF2E0J>;
	Fri, 29 Jun 2001 00:26:09 -0400
Date: Fri, 29 Jun 2001 00:26:47 +0000 (UTC)
From: <robs@Op.Net>
X-X-Sender: <robs@wd2500>
To: <linux-kernel@vger.kernel.org>
Subject: ac20, ac21 make config error
Message-ID: <Pine.LNX.4.33.0106290022440.1239-100000@wd2500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in "linux/drivers/net/Config.in"

 line 30 used to be:


if [ "$CONFIG_NET_ETHERNET" = "y" ]; then


It seems to have been deleted.  Putting it back, everything goes as it
should. :)

Thanks!!

Rob


