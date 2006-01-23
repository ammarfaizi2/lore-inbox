Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWAWCEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWAWCEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWAWCEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:04:36 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:58126 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751379AbWAWCEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:04:36 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: torvalds@osdl.org (Linus Torvalds)
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
Cc: bboissin@gmail.com, laforge@netfilter.org, xslaby@fi.muni.cz,
       akpm@osdl.org, linux-kernel@vger.kernel.org, davem@davemloft.net
Organization: Core
In-Reply-To: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F0r3A-0006m2-00@gondolin.me.apana.org.au>
Date: Mon, 23 Jan 2006 13:03:20 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Interestingly, __alignof__(unsigned long long) is 8 these days, even 
> though I think historically on x86 it was 4. Is this perhaps different in 
> gcc-3 and gcc-4?

gcc 2.95 says 4 while gcc 3.2 says 8.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
