Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270663AbTG0EWT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 00:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270664AbTG0EWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 00:22:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18960 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S270663AbTG0EWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 00:22:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mjferna@yahoo.com (Marino Fernandez), linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0 wont let me unmount eth0 upon reboot
In-Reply-To: <200307261951.40050.mjferna@yahoo.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.21-2-686-smp (i686))
Message-Id: <E19gdHW-0004zt-00@gondolin.me.apana.org.au>
Date: Sun, 27 Jul 2003 14:37:14 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marino Fernandez <mjferna@yahoo.com> wrote:
> I've trying the new kernel. Everything is OK, except that when I shut down my 
> machine, I get this message:
> 
> unmounting remote filesystems
> unregistering_netdevice: waiting for eth0 to become free. usage count = -4

Disabled CONFIG_IPV6_PRIVACY or run the latest BK source.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
