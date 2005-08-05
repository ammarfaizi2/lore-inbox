Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVHEBMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVHEBMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHEBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:09:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262809AbVHEBJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:09:30 -0400
Date: Thu, 4 Aug 2005 18:08:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: guillaume.pelat@winch-hebergement.net, davem@davemloft.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [TCP]: Fix TSO cwnd caching bug
Message-Id: <20050804180813.366c6f31.akpm@osdl.org>
In-Reply-To: <20050805005741.GA17960@gondor.apana.org.au>
References: <42EDDE50.6050800@winch-hebergement.net>
	<20050804033329.GA14501@gondor.apana.org.au>
	<20050804103523.GA11381@gondor.apana.org.au>
	<42F25352.8050805@winch-hebergement.net>
	<20050804165842.4d673f97.akpm@osdl.org>
	<20050805005741.GA17960@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Aug 04, 2005 at 04:58:42PM -0700, Andrew Morton wrote:
>  > 
>  > Thanks, Guillaume.  Herbert, David is travelling and not able to do a lot
>  > of patchmonkeying.  Could you please prepare and submit a final patch?
> 
>  OK, here is the final version.

Thanks.

>  It depends on the patch that David
>  posted earlier on in this thread.  Please let me know if you need a
>  copy of that.

Yes please.
