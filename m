Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVFOVnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVFOVnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFOVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:42:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33453
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261604AbVFOVlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:41:32 -0400
Date: Wed, 15 Jun 2005 14:41:16 -0700 (PDT)
Message-Id: <20050615.144116.41632938.davem@davemloft.net>
To: juhl-lkml@dif.dk
Cc: yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, jmorris@redhat.com,
       ross.biro@gmail.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH][4/4] net: signed vs unsigned cleanup in
 net/ipv4/raw.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506152338450.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152316060.3842@dragon.hyggekrogen.localhost>
	<20050615.142953.59469324.davem@davemloft.net>
	<Pine.LNX.4.62.0506152338450.3842@dragon.hyggekrogen.localhost>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>
Date: Wed, 15 Jun 2005 23:40:12 +0200 (CEST)

> On Wed, 15 Jun 2005, David S. Miller wrote:
> 
> > I think I'd prefer that.
> > 
> No problem. Here's a replacement patch nr. 4 : 

Thanks a lot.  All 4 patches applied to my 2.6.13-pending tree.
