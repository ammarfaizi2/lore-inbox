Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVCPXDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVCPXDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVCPXBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:01:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:63616 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262852AbVCPW7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:59:50 -0500
Date: Thu, 17 Mar 2005 00:01:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok
 (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok)
 (fwd)
In-Reply-To: <20050316145524.18787569.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0503170000250.2558@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost>
 <20050316145524.18787569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > Around 2.6.11-mm1 Yoichi Yuasa found a user of verify_area that I had 
> >  missed when converting everything to access_ok. The patch below still 
> >  applies cleanly to 2.6.11-mm4.
> >  Please apply (unless of course you already picked it up back then and 
> >  have it in a queue somewhere :) .
> 
> That's tricky stuff you're playing with, so I'd prefer it came in via Ralf.
> However I can queue it up locally so it doesn't get forgotten.
> 
Perfectly fine by me.

-- 
Jesper


