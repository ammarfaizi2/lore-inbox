Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUIRFWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUIRFWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 01:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbUIRFWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 01:22:39 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:46606 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267555AbUIRFWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 01:22:37 -0400
Message-ID: <9e473391040917222253f8bf03@mail.gmail.com>
Date: Sat, 18 Sep 2004 01:22:31 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Cc: davem@davemloft.net, david@gibson.dropbear.id.au, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20040918041627.GA12356@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091717215e9be08b@mail.gmail.com>
	 <E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
	 <9e473391040917183726113e91@mail.gmail.com>
	 <20040918041627.GA12356@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still getting the same fault with the patch. Someone else has this
problem too. The full stack trace is in this thread....

[2.6.9-rc2-bk] Network-related panic on boot  

-- 
Jon Smirl
jonsmirl@gmail.com
