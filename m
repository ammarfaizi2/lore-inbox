Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272382AbTG3L0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbTG3LZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:25:44 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:8716 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272822AbTG3LYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:24:00 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: christian@borntraeger.net (Christian Borntr?ger),
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Linux v2.6.0-test2
In-Reply-To: <200307291601.01730.christian@borntraeger.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.21-2-686-smp (i686))
Message-Id: <E19hp35-0000U6-00@gondolin.me.apana.org.au>
Date: Wed, 30 Jul 2003 21:23:15 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntr?ger <christian@borntraeger.net> wrote:
> Linus Torvalds wrote:
>> Herbert Xu:
>>   o [IPSEC]: Make reqids 32-bits
> 
> Is this the reason why I can connect
> 2.6.0-test1 with 2.6.0-test1
> 2.6.0-test2 with 2.6.0-test2
> 
> but 2.6.0-test1 cannot connect to 2.6.0-test2 with ipsec?

Does it work after you recompile your user space tools against
headers from 2.6.0-test2?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
