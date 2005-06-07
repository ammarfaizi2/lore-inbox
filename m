Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVFGCgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVFGCgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVFGCgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:36:11 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:59141 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261591AbVFGCej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:34:39 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Resend: [PATCH] crypto: don't check for NULL before kfree(), it's redundant.
Cc: jmorris@intercode.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <9a8748490506061650477c8b7@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DfTul-0002H4-00@gondolin.me.apana.org.au>
Date: Tue, 07 Jun 2005 12:34:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> Here's a resend of a patch originally for 2.6.12-rc1-mm4. It still
> applies to 2.6.12-rc6
> 
> The patch removes redundant checks of NULL before kfree() in crypto/ .
> 
> Patch attached as well as inline since I don't know how well gmail
> handles inline patches.

I've already merged your patch.  It will be pushed upstream after
2.6.12 is released.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
