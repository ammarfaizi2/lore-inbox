Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFNBMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFNBMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFNBMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:12:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65003
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261239AbVFNBMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:12:13 -0400
Date: Mon, 13 Jun 2005 18:11:55 -0700 (PDT)
Message-Id: <20050613.181155.63129744.davem@davemloft.net>
To: ak@muc.de
Cc: jesper.juhl@gmail.com, mru@inprovide.com, rommer@active.by,
       bernd@firmix.at, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: udp.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050614001249.GF86745@muc.de>
References: <m1fyvlbyp7.fsf@muc.de>
	<20050613.170045.74749212.davem@davemloft.net>
	<20050614001249.GF86745@muc.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>
Date: 14 Jun 2005 02:12:49 +0200,Tue, 14 Jun 2005 02:12:49 +0200

> Ok I can fix it, but only reasonably after mem_init (at least without
> hacking up change_page_attr a lot to deal with bootmem).
> Is that still worth it? 

I think so.
