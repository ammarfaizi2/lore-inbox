Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUIRPbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUIRPbd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269580AbUIRPbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:31:33 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:38358 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269183AbUIRP2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:28:02 -0400
Message-ID: <9e47339104091808282df3dfe8@mail.gmail.com>
Date: Sat, 18 Sep 2004 11:28:00 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Cc: Herbert Xu <herbert@gondor.apana.org.au>, david@gibson.dropbear.id.au,
       akpm@osdl.org, trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20040917233108.561c88d6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091717215e9be08b@mail.gmail.com>
	 <E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
	 <9e473391040917183726113e91@mail.gmail.com>
	 <20040918041627.GA12356@gondor.apana.org.au>
	 <20040917233108.561c88d6.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch fixes things so that I can boot. The net is working too.

-- 
Jon Smirl
jonsmirl@gmail.com
