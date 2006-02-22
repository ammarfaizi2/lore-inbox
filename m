Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWBVLpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWBVLpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWBVLpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:45:36 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:12037
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1750827AbWBVLpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:45:35 -0500
Date: Wed, 22 Feb 2006 22:45:31 +1100
To: Michael Heyse <mhk@designassembly.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: which one is broken: VIA padlock aes or aes_i586?
Message-ID: <20060222114531.GA4170@gondor.apana.org.au>
References: <43FB0746.5010200@designassembly.de> <20060222013137.GA844@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222013137.GA844@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:31:37PM +1100, herbert wrote:
>
> I don't think this patch is your problem since it's part of the multiblock
> code which doesn't exist in 2.6.12 at all.  Of course the multiblock code
> itself could be buggy.  I'll take a look.

OK I can't reproduce this.  Please send me your dmcrypt setup line so
I can try it here.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
