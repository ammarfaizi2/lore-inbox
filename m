Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVCCG1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVCCG1C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCCGYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:24:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16146 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261548AbVCCGVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:21:53 -0500
Date: Thu, 3 Mar 2005 07:21:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303062135.GE30106@alpha.home.local>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42268F93.6060504@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


100% agree with you, Jeff. That's what I wrote in another mail.
A real -rc should have only a handful of patches. And even more
importantly, the final release MUST be EXACTLY the lastest -rc,
without any new surprize.

Willy

On Wed, Mar 02, 2005 at 11:16:19PM -0500, Jeff Garzik wrote:
 
> The reasons -rcs are not as good as they could be is that they include 
> more than just bug fixes.  Users are discouraged from testing because 
> they must scan LKML, or guess, which -rc that Linus/Andrew started 
> getting serious about "bugfixes only."
> 
> With the -pre/-rc scheme, it's clear to users.
> 
> With the even/odd scheme, you just devalue releases.  Previously, all 
> releases were worthy of testing and use.  Now, half of them aren't.
> 
> 	Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
