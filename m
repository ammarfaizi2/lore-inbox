Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVAQB0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVAQB0C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 20:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVAQB0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 20:26:02 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:47114 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262660AbVAQBZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 20:25:59 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dan1965@gmx.de (Daniel Schmidt)
Subject: Re: Kernel config: "Use TOS as routing key"
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1812.1105883765@www1.gmx.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CqLde-00050n-00@gondolin.me.apana.org.au>
Date: Mon, 17 Jan 2005 12:25:02 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Schmidt <dan1965@gmx.de> wrote:
> 
> some time ago, there was an option "Use TOS as routing key" in the kernel
> configuration. I used it to priorize for example ssh connections, by
> modifying their TOS value using iptables.
> 
> This option seems to have gone in a recent 2.6.10 kernel. Is there any way
> to reenable it?

It's always on now.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
