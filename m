Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbUJ0Hlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbUJ0Hlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUJ0Hlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:41:55 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:34196 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262306AbUJ0Hlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:41:52 -0400
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: Re: DVD/ide-cd related Oops 2.6.[89]-mm
Date: Wed, 27 Oct 2004 03:41:46 -0400
User-Agent: KMail/1.7
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
References: <20041022090145.GA6408@tabriel.tabris.net>
In-Reply-To: <20041022090145.GA6408@tabriel.tabris.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410270341.46839.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 5:01 am, Tabris wrote:
> 	I have a DVD I bought today that about 80% of the way through
> causes an error, 'cmd 0x28 timed out', resets ATAPI 2 or 3 times...
> and then produces the Oops attached below.
	Any thoughts on the DVD oops? I'd like to be able to find a fix for 
this so I can actually watch the movie.
>
> 	This has happened in 2.6.8-rc1-mm1+idefix2 (a mebbe 5 liner
> patch to fix LBA 48 FLUSH CACHE on non-LBA48 capable drives from
> Jens. was merged into rc2-mm, possibly in rc1-mm2 or mm3), and also
> 2.6.9-rc4-mm1+revert_optimize-profile+undecoded_slave-fixup
>
<snip>
> 	Btw, the oops does not occur with another DVD I have. However, I
> did go to the store and get another copy of the problematic DVD, and
> the same problem occurred.
> --
> tabris

-- 
Fundamentally, there may be no basis for anything.
