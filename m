Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVCCDlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVCCDlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVCCDhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:37:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:44466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261465AbVCCDg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:36:28 -0500
Date: Wed, 2 Mar 2005 19:37:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <422674A4.9080209@pobox.com>
Message-ID: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Jeff Garzik wrote:
> 
> If we want a calming period, we need to do development like 2.4.x is 
> done today.  It's sane, understandable and it works.

No. It's insane, and the only reason it works is that 2.4.x is a totally
different animal. Namely it doesn't have the kind of active development AT
ALL any more. It _only_ has the "even" number kind of things, and quite 
frankly, even those are a lot less than 2.6.x has.

> 2.6.x-pre: bugfixes and features
> 2.6.x-rc: bugfixes only

And the reason it does _not_ work is that all the people we want testing 
sure as _hell_ won't be testing -rc versions.

That's the whole point here, at least to me. I want to have people test 
things out, but it doesn't matter how many -rc kernels I'd do, it just 
won't happen. It's not a "real release".

In contrast, making it a real release, and making it clear that it's a 
release in its own right, might actually get people to use it. 

Might. Maybe.

			Linus
