Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUKOBT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUKOBT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKOBT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:19:57 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:35089 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261436AbUKOBTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:19:45 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ralf.Hildebrandt@charite.de (Ralf Hildebrandt)
Subject: Re: Linux 2.6.9-ac8
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20041114182138.GF5708@charite.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CTVWg-00079i-00@gondolin.me.apana.org.au>
Date: Mon, 15 Nov 2004 12:19:26 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:
> 
> I'm seeing these with 2.6.9-ac8:
> 
> Nov 14 18:40:09 kasbah kernel: retrans_out leaked.                      
> Nov 14 18:41:25 kasbah kernel: retrans_out leaked.                      
> Nov 14 18:42:44 kasbah kernel: retrans_out leaked.                      
> 
> What is that?

There are known TCP problems in 2.6.9.  Please test 2.6.10-rc1 or
later.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
