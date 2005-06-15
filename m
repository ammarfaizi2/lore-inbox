Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFOT6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFOT6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVFOT6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:58:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36028
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261532AbVFOT63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:58:29 -0400
Date: Wed, 15 Jun 2005 12:58:04 -0700 (PDT)
Message-Id: <20050615.125804.126575159.davem@davemloft.net>
To: juhl-lkml@dif.dk
Cc: yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, jmorris@redhat.com,
       waltje@uWalt.NL.Mugnet.ORG, ross.biro@gmail.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] signed vs unsigned cleanup in net/ipv4/raw.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506152127150.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152101350.3842@dragon.hyggekrogen.localhost>
	<20050615.121628.112622743.davem@davemloft.net>
	<Pine.LNX.4.62.0506152127150.3842@dragon.hyggekrogen.localhost>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>
Date: Wed, 15 Jun 2005 21:28:23 +0200 (CEST)

> Fair enough, I'll split it into little bits and submit them one by one 
> with explanations. Not a problem at all.

Thanks a lot Jesper.
