Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVG0V4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVG0V4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVG0Vih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:38:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14307
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261164AbVG0ViE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:38:04 -0400
Date: Wed, 27 Jul 2005 14:38:01 -0700 (PDT)
Message-Id: <20050727.143801.51840907.davem@davemloft.net>
To: andrew@mcdonald.org.uk
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13rc3] IPv6: Check interface bindings on IPv6 raw
 socket reception
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050723180442.GB6731@mcdonald.org.uk>
References: <20050723180442.GB6731@mcdonald.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew McDonald <andrew@mcdonald.org.uk>
Date: Sat, 23 Jul 2005 19:04:43 +0100

> Take account of whether a socket is bound to a particular device when
> selecting an IPv6 raw socket to receive a packet. Also perform this
> check when receiving IPv6 packets with router alert options.
> 
> Signed-off-by: Andrew McDonald <andrew@mcdonald.org.uk>

Applied, thanks Andrew.
