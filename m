Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVIWTsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVIWTsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVIWTsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:48:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751192AbVIWTsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:48:22 -0400
Date: Fri, 23 Sep 2005 12:47:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: chris@sigsegv.plus.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-Id: <20050923124727.7c3ffa22.akpm@osdl.org>
In-Reply-To: <9a8748490509231245d26d875@mail.gmail.com>
References: <20050922163708.GF5898@sigsegv.plus.com>
	<20050923015719.5eb765a4.akpm@osdl.org>
	<20050923121932.GA5395@sigsegv.plus.com>
	<20050923132216.GA5784@sigsegv.plus.com>
	<20050923121811.2ef1f0be.akpm@osdl.org>
	<9a8748490509231245d26d875@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> On 9/23/05, Andrew Morton <akpm@osdl.org> wrote:
> [snip]
> >
> > We ought to have the git bisection process documented in the kernel tree,
> > but we don't, alas.  There's stuff at http://lkml.org/lkml/2005/6/24/234
> > but a standalone document which walks people through installing git,
> > pulling the initial tree, building and bisecting is needed (hint).
> >
> 
> If noone else is doing this then I'll write such a document.

Thanks.

> If someone has already started writing it, then please let me know so
> we don't duplicate work. I'll get write it during the weekend if I
> hear nothing.

I suspect you're pretty safe ;)
