Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUFNF1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUFNF1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 01:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUFNF1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 01:27:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:40964 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261937AbUFNF1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 01:27:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jgarzik@pobox.com (Jeff Garzik)
Subject: Re: [1/12] don't dereference netdev->name before register_netdev()
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <40CD293D.4040808@pobox.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BZjzZ-0000D4-00@gondolin.me.apana.org.au>
Date: Mon, 14 Jun 2004 15:26:45 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> Herbert Xu has an updated patch for this, I'll compare both more closely...

Please ignore the one posted in this thread.  It is hopelessly out
of date.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
