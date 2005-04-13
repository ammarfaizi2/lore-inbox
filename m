Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVDMMD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVDMMD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDMMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:03:26 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:60424 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261315AbVDMMDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:03:24 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ast@domdv.de (Andreas Steinmetz)
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Cc: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <425BCA6E.8030408@domdv.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au>
Date: Wed, 13 Apr 2005 21:59:24 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
> 
> Here comes the next incarnation, this time against 2.6.12rc2.
> Unfortunately only compile tested as 2.6.12rc2 happily oopses away
> (vanilla from kernel.org, oops already sent to lkml).
> 
> Please let me know if you want any further changes.

What's wrong with using swap over dmcrypt + initramfs? People have
already used that to do encrypted swsusp.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
