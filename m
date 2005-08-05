Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVHEJGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVHEJGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVHEJGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:06:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57219
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262916AbVHEJF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:05:59 -0400
Date: Fri, 05 Aug 2005 02:06:01 -0700 (PDT)
Message-Id: <20050805.020601.74738947.davem@davemloft.net>
To: kaber@trash.net
Cc: malattia@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow at
 ip_conntrack_event_cache_init+0x91/0xb0 (with patch)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42F10E51.9000605@trash.net>
References: <42EEC2BB.3020105@trash.net>
	<20050802132922.GA3834@inferi.kami.home>
	<42F10E51.9000605@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 03 Aug 2005 20:34:57 +0200

> [NETFILTER]: Fix multiple problems with the conntrack event cache

Applied to net-2.6.14, thanks Patrick.
