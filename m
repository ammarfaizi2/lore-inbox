Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVCQNQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVCQNQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVCQNQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 08:16:12 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:31003 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262047AbVCQNQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 08:16:09 -0500
Date: Thu, 17 Mar 2005 13:14:55 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, yuasa@hh.iij4u.or.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok) (fwd)
Message-ID: <20050317131455.GB5204@linux-mips.org>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost> <20050316145524.18787569.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316145524.18787569.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:55:24PM -0800, Andrew Morton wrote:

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
> Ralf must have another two megabyte patch buffered up by now, btw?

Quite a bit less and much of the diff are patches that must be somewhere
in Jeff's network driver queue.  But yes, hint taken, you'll get your
patch easter egg ;-0

  Ralf
