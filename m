Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTFDJeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 05:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTFDJeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 05:34:36 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1796 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261352AbTFDJef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 05:34:35 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: andreas@xss.co.at (Andreas Haumer), linux-kernel@vger.kernel.org
Subject: Re: system clock speed too high?
In-Reply-To: <3EDBA83B.5050406@xss.co.at>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19NUrl-0002xI-00@gondolin.me.apana.org.au>
Date: Wed, 04 Jun 2003 19:47:33 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Haumer <andreas@xss.co.at> wrote:
> 
> I have a quite strange phenomenon here: I see a ~2.5 times
> speed up of system time on a Asus AP1700-S5 server with
> Linux-2.4.21-rc6-ac1.

I see exactly the opposite.  The time is ~2.5 times slower with
2.4.21-rc6.

This is actually in a VMware setup on a P4 machine.  The same setup
runs 2.4.20, 2.5.69 and 2.5.70 correctly.

I'm going to play with it right after I get IDE modules working
properly.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
