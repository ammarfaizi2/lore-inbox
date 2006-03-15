Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWCOKNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWCOKNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWCOKNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:13:32 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:524
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751379AbWCOKNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:13:32 -0500
Date: Wed, 15 Mar 2006 21:13:15 +1100
To: David McCullough <david_mccullough@au.securecomputing.com>
Cc: Valdis.Kletnieks@vt.edu, Adrian Bunk <bunk@stusta.de>, davem@davemloft.net,
       linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/aes.c: array overrun
Message-ID: <20060315101315.GC23747@gondor.apana.org.au>
References: <20060311010339.GF21864@stusta.de> <20060311024116.GA21856@gondor.apana.org.au> <200603142025.k2EKP8Z4010175@turing-police.cc.vt.edu> <20060314225448.GA27285@beast> <20060315003212.GA20843@gondor.apana.org.au> <20060315011132.GA28323@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315011132.GA28323@beast>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 11:11:32AM +1000, David McCullough wrote:
> 
> No problems, attached.

Patch applied.  BTW, please attach a Signed-off-by line for your next
patch submission.  Thanks a lot.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
