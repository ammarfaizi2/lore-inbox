Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbTFMKxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265349AbTFMKxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:53:45 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6149 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S265346AbTFMKxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:53:44 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: paulus@samba.org (Paul Mackerras), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <16105.44765.930081.44739@cargo.ozlabs.ibm.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19QmOw-00040x-00@gondolin.me.apana.org.au>
Date: Fri, 13 Jun 2003 21:07:22 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
> Alan Cox writes:
> 
>> lock xaddl $1, [foo]
> 
> On 386?  I stand corrected. :)

My instruction manual lists it as 486 only.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
