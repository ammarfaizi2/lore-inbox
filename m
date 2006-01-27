Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWA0BKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWA0BKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWA0BKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:10:15 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:36868 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932409AbWA0BKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:10:13 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David H?rdeman <david@2gen.com>
Subject: Re: [PATCH 00/04] Add DSA key type
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@linux-nfs.org,
       david@2gen.com
Organization: Core
In-Reply-To: <1138312694656@2gen.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F2I7q-0007F6-00@gondolin.me.apana.org.au>
Date: Fri, 27 Jan 2006 12:10:06 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David H?rdeman <david@2gen.com> wrote:
>
> crypto/mpi/Makefile               |   31 

Wouldn't this make more sense under lib/mpi?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
