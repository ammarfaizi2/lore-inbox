Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJGIxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTJGIxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:53:21 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62214 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261895AbTJGIxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:53:20 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: skraw@ithnet.com (Stephan von Krawczynski), linux-kernel@vger.kernel.org
Subject: Re: Alias names for network devices?
Organization: Core
In-Reply-To: <20031006131051.107510d0.skraw@ithnet.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1A6nag-0003Xn-00@gondolin.me.apana.org.au>
Date: Tue, 07 Oct 2003 18:53:10 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> does anybody have an idea how to map a static device name to a network device
> with dynamic appearance (e.g. ppp) ?

Yes, you can rename interfaces easily.

For ppp the best solution is to patch pppd to do it.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
