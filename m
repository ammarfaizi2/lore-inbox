Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVFWVND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVFWVND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVFWVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:12:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57992
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261709AbVFWVKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:10:45 -0400
Date: Thu, 23 Jun 2005 14:10:38 -0700 (PDT)
Message-Id: <20050623.141038.122619255.davem@davemloft.net>
To: jesper.juhl@gmail.com, juhl-lkml@dif.dk
Cc: loz@holmes.demon.co.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLIP: simplify sl_free_bufs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506232243340.7467@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152136310.3842@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.62.0506232243340.7467@dragon.hyggekrogen.localhost>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>
Date: Thu, 23 Jun 2005 22:46:06 +0200 (CEST)

> The patch below still applies cleanly to 2.6.12 - any chance this might 
> get applied? or any good reasons not to apply it?

I'll put it in my tree, give me a day or so.
