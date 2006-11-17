Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424753AbWKQCo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424753AbWKQCo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 21:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424752AbWKQCo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 21:44:26 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:25617 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1424304AbWKQCoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 21:44:25 -0500
Date: Fri, 17 Nov 2006 13:44:16 +1100
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [-mm patch] crypto/xcbc.c: make some code static
Message-ID: <20061117024416.GA17286@gondor.apana.org.au>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117011929.GP31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117011929.GP31879@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 02:19:29AM +0100, Adrian Bunk wrote:
> On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc5-mm2:
> >...
> >  git-cryptodev.patch
> >...
> >  git trees
> >...
> 
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Both patches applied.  Thanks Adrian.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
