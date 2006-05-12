Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWELAbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWELAbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWELAbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:31:10 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:10505 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750729AbWELAbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:31:09 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: brice@myri.com (Brice Goglin)
Subject: Re: [PATCH 5/6] myri10ge - Second half of the driver
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       gallatin@myri.com
Organization: Core
In-Reply-To: <4463CE71.1000205@myri.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FeLYc-0000y4-00@gondolin.me.apana.org.au>
Date: Fri, 12 May 2006 10:31:02 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <brice@myri.com> wrote:
>
>> It is preferred to put function declarations on one line.
>>
>> static int mril10ge_open(struct net_device *dev)
> 
> Well, I have seen several threads about this in the archive, with some
> people against and some people pro. I personaly like grepping for the
> declaration of function using ^name.
> If this codingstyle is really required, I will do.

Yes this is the standard coding style used in Linux so please do.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
