Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWIAKmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWIAKmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 06:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWIAKmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 06:42:14 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:32015 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751438AbWIAKmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 06:42:13 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jesper.juhl@gmail.com (Jesper Juhl)
Subject: Re: Unable to halt or reboot due to - unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       waltje@uwalt.nl.mugnet.org, ross.biro@gmail.com, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <9a8748490609010259l7c42ca88tbcc87410a770b48c@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GJ6St-0004Te-00@gondolin.me.apana.org.au>
Date: Fri, 01 Sep 2006 20:41:35 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> I've just encountered the problem on a different server with an
> identical vlan setup. That server is running 2.6.13.4

Do you have a simple recipe to reproduce this? Ideally it'd be a
script that anyone can execute in a freshly booted system that
exhibits the problem.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
