Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVDRMhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVDRMhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDRMhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:37:08 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6663 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262061AbVDRMg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:36:57 -0400
Date: Mon, 18 Apr 2005 22:33:05 +1000
To: Andreas Steinmetz <ast@domdv.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: Re: [RFC][PATCH 2/4] AES assembler implementation for x86_64
Message-ID: <20050418123305.GA7388@gondor.apana.org.au>
References: <4262B6E9.8040400@domdv.de> <200504181118.50594.vda@ilport.com.ua> <42637775.8000904@domdv.de> <200504181319.15708.vda@ilport.com.ua> <42638D53.9070809@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42638D53.9070809@domdv.de>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:34:59PM +0200, Andreas Steinmetz wrote:
> Denis Vlasenko wrote:
>
> > OTOH, if _exactly the same file_ exist in i384 arch, then
> > you should not duplicate it at all. Find a way to use one file
> > for both arches.

I haven't looked at the patches yet, but if it were possible to
share code such as gen_tab then it would be very nice indeed.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
