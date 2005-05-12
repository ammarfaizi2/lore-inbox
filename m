Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVELIml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVELIml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVELIml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:42:41 -0400
Received: from mail.dif.dk ([193.138.115.101]:33414 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261326AbVELImQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:42:16 -0400
Date: Thu, 12 May 2005 10:41:33 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: "David S.Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace 
 cleanup)
In-Reply-To: <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org>
Message-ID: <Pine.LNX.4.62.0505121038420.13119@jjulnx.backbone.dif.dk>
References: <42Mbg-Tq-25@gated-at.bofh.it> <42MXA-1zI-3@gated-at.bofh.it>
 <42MXA-1zI-1@gated-at.bofh.it> <42Nh3-1M8-17@gated-at.bofh.it>
 <42Nh3-1M8-15@gated-at.bofh.it> <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

> Date: Thu, 12 May 2005 01:47:28 +0200
> From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>"
>     <7eggert@gmx.de>
> To: Jesper Juhl <juhl-lkml@dif.dk>, David S.Miller <davem@davemloft.net>,
>     Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace 
>     cleanup)
> 
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> > If Andrew agrees, then I'll commit to doing this cleanup;
> 
> > - (to a limited degree) no trailing whitespace
> 
> I just ran a script over -rc4 to remove trailing ws. The result is
> about 22 MB in 429 patches (iterated over ./*/*).
> 
Ok, I'm not looking at trailing ws yet. I'm working on the "two statements 
on one line" and "spaces between function name and opening paren" bits. 
It's a bit slow going since I don't have many hours a day untill the 
weekend, but I hope to have the first batch of patches ready over the 
weekend.

> How hard can I patch you before you start patching me?
> 
Let me have a copy of your patches, then I can do my work incremental to 
yours.  If you could tar & gz them and attach them to a mail and send it 
to me in private email that would be perfect.


/Jesper


