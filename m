Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVCPW4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVCPW4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVCPW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:56:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:16868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262846AbVCPWz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:55:58 -0500
Date: Wed, 16 Mar 2005 14:55:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok
 (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok)
 (fwd)
Message-Id: <20050316145524.18787569.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> Around 2.6.11-mm1 Yoichi Yuasa found a user of verify_area that I had 
>  missed when converting everything to access_ok. The patch below still 
>  applies cleanly to 2.6.11-mm4.
>  Please apply (unless of course you already picked it up back then and 
>  have it in a queue somewhere :) .

That's tricky stuff you're playing with, so I'd prefer it came in via Ralf.
However I can queue it up locally so it doesn't get forgotten.

Ralf must have another two megabyte patch buffered up by now, btw?
