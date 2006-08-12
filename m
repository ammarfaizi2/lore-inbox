Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWHLDOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWHLDOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 23:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHLDOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 23:14:05 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:41735 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750811AbWHLDOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 23:14:03 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kornos.it@gmail.com (Luca)
Subject: Re: [2.6.18-rc4] lockdep warning at inet6_addr_add
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060811162352.GA14795@dreamland.darkstar.lan>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GBjwm-0004pd-00@gondolin.me.apana.org.au>
Date: Sat, 12 Aug 2006 13:14:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca <kornos.it@gmail.com> wrote:
> I get a warning from lockdep during boot; 2.6.18-rc3 don't have this
> warning. I see a similar report in the archive (I haven't found time to
> test the patch...):
> 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=115506258902757&w=2

It's the same issue.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
