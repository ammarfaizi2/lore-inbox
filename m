Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269078AbUIRA21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269078AbUIRA21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUIRA21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 20:28:27 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:64270 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269078AbUIRA20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 20:28:26 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Cc: davem@davemloft.net, david@gibson.dropbear.id.au, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Organization: Core
In-Reply-To: <9e47339104091717215e9be08b@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1C8T4t-0006ug-00@gondolin.me.apana.org.au>
Date: Sat, 18 Sep 2004 10:27:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm still OOPsing at boot in fib_disable_ip+21 from
> fib_netdev_event+63. Both e1000 and tg3 are effected. I have current
> linus bk as of time of this message.

Please post the complete error message.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
