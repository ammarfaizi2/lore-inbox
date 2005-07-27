Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVG0WCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVG0WCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVG0WAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:00:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15587
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261197AbVG0ViW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:38:22 -0400
Date: Wed, 27 Jul 2005 14:38:14 -0700 (PDT)
Message-Id: <20050727.143814.93382540.davem@davemloft.net>
To: kaber@trash.net
Cc: andrew@mcdonald.org.uk, netdev@vger.kernel.org, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13rc3] IPv6: Check interface bindings on IPv6 raw
 socket reception
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42E32980.2090604@trash.net>
References: <20050723180442.GB6731@mcdonald.org.uk>
	<42E2DFAE.8070101@trash.net>
	<42E32980.2090604@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Sun, 24 Jul 2005 07:39:12 +0200

> [IPV4/6]: Check if packet was actually delivered to a raw socket to decide whether to send an ICMP unreachable
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>

Applied, thanks Patrick.
