Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVAYGv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVAYGv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVAYGv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:51:59 -0500
Received: from colin2.muc.de ([193.149.48.15]:15882 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261840AbVAYGv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:51:58 -0500
Date: 25 Jan 2005 07:51:57 +0100
Date: Tue, 25 Jan 2005 07:51:57 +0100
From: Andi Kleen <ak@muc.de>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>,
       Tim Hockin <thockin@hockin.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050125065157.GA8297@muc.de>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de> <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost> <20050123044637.GA54433@muc.de> <41F570F3.3020306@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F570F3.3020306@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, we already have a Shell sort for the ngroups stuff in
> kernel/sys.c:groups_sort() that could be made generic.

Sounds like a good plan. Any takers?

-Andi
