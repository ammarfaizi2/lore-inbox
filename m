Return-Path: <linux-kernel-owner+w=401wt.eu-S1423178AbWLVBDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423178AbWLVBDz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 20:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423177AbWLVBDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 20:03:55 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:4871 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423175AbWLVBDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 20:03:54 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mjg59@srcf.ucam.org (Matthew Garrett)
Subject: Re: Network drivers that don't suspend on interface down
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20061220143134.GA25462@srcf.ucam.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GxYoS-0003GL-00@gondolin.me.apana.org.au>
Date: Fri, 22 Dec 2006 12:03:04 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> In terms of what I've seen on vaguely modern hardware, I'd guess at 
> e1000 and sky2 as the top ones. b44 is still common in cheaper hardware, 
> with via-rhine appearing at the very low end. I'll try to grep through 
> our hardware database results to get a stronger idea about percentages.

The Sony laptop that I bought a year ago still has an e100 chipset so
that's probably worth fixing too.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
