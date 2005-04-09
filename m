Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVDIBpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDIBpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVDIBpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:45:13 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:40459 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261245AbVDIBpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:45:03 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: rddunlap@osdl.org, linux-os@analogic.com, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <aec7e5c305040711535bbe07d3@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DK4zA-0005rr-00@gondolin.me.apana.org.au>
Date: Sat, 09 Apr 2005 11:42:08 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> Say a kernel shipped with your favourite distribution crashes your
> machine during boot-up - wouldn't it be nice to be able to just
> disable the problematic module from the kernel command line instead of

Perhaps your favourite distribution could build that as a module to
start with.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
