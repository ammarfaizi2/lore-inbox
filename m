Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTKBUeO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTKBUeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 15:34:14 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:37125 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261799AbTKBUeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 15:34:04 -0500
Date: Mon, 3 Nov 2003 07:33:50 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031102203350.GA9402@gondor.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <3FA4EF79.5060708@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA4EF79.5060708@namesys.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 02:50:17PM +0300, Hans Reiser wrote:
>
> Why are you guys modifying the official kernel?  Are you seeking 
> advantage over the other distros or?  This was one of the nice things 
> about debian, that it didn't have unofficial destabilizing stuff in the 
> kernel like the other distros.

I don't know where you got the idea that Debian used to distribute the
kernel as it is.  Just like every other distribution, we have always
needed (mostly small) changes to the vanilla kernel.

We do send those changes suitable for general consumption to the
upstream maintainers.  Whether they are accepted is an entirely
different question.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
