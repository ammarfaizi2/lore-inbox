Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTKFVJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTKFVJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:09:25 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:63497 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263834AbTKFVJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:09:14 -0500
Date: Fri, 7 Nov 2003 08:09:00 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031106210900.GA29000@gondor.apana.org.au>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105094855.GD1477@suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 10:48:55AM +0100, Jens Axboe wrote:
> 
> I don't see any problems with this approach, I'll commit the code.

Actually, please hold onto that patch if possible, I've just received
a report that it maybe causing worse problems than the one it solves.

I'll get back to you.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
