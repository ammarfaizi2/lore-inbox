Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945956AbWGOAja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945956AbWGOAja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945954AbWGOAj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:39:29 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:9991 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1945955AbWGOAj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:39:27 -0400
Date: Sat, 15 Jul 2006 10:39:00 +1000
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Michal Ludvig <michal@logix.cz>,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       linux-crypto@vger.kernel.org
Subject: Re: [-mm patch] drivers/crypto/padlock-sha.c: make 2 functions static
Message-ID: <20060715003900.GA11515@gondor.apana.org.au>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003540.GI3633@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715003540.GI3633@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 02:35:40AM +0200, Adrian Bunk wrote:
> This patch makes two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks, patch applied.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
