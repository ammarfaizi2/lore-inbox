Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVHEId2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVHEId2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVHEId2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:33:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17361
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262911AbVHEIdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:33:25 -0400
Date: Fri, 05 Aug 2005 01:33:26 -0700 (PDT)
Message-Id: <20050805.013326.85408053.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: akpm@osdl.org, guillaume.pelat@winch-hebergement.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [TCP]: Fix TSO cwnd caching bug
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050805005741.GA17960@gondor.apana.org.au>
References: <42F25352.8050805@winch-hebergement.net>
	<20050804165842.4d673f97.akpm@osdl.org>
	<20050805005741.GA17960@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 5 Aug 2005 10:57:41 +1000

> OK, here is the final version.  It depends on the patch that David
> posted earlier on in this thread.  Please let me know if you need a
> copy of that.
> 
> [TCP]: Fix TSO cwnd caching bug

Good catch Herbert :)
