Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVJPHVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVJPHVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVJPHVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 03:21:53 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:4870 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751297AbVJPHVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 03:21:53 -0400
Date: Sun, 16 Oct 2005 17:21:36 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Message-ID: <20051016072136.GA4827@gondor.apana.org.au>
References: <200510152224.j9FMOvmO012626@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510152224.j9FMOvmO012626@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 03:24:57PM -0700, Suzanne Wood wrote:
> 
> Please find attached a patch to drivers/net/hamradio/bpqether.c
> that might finally merit being
> Signed-off-by: suzannew@cs.pdx.edu

Looks good to me.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

You might want to send this patch to ralf@linux-mips.org who
is the current maintainer.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
