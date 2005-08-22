Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVHVWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVHVWtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVHVWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:49:19 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:20493 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750737AbVHVWtS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:49:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QyboKGVCtU45+TDDP+ezlfR7T53JCCKpGBvHAE9QhYMY+ycYDH66cT6CvA8vEGgBwh6mtVct9Nyloc4D7LoHOZ3CrTgllmtYokWQPsYrBxlSmA7/sWXmId32tcqVO2t0d+zXkdvon6m/yzFpzsoOvSa7eVGBtWI817PIkDob+ag=
Message-ID: <9a87484905082215492d6c1dca@mail.gmail.com>
Date: Tue, 23 Aug 2005 00:49:17 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Subject: Re: [PATCH] make loglevels in init/main.c a little more sane.
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050822054147.GA20546@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0501222229210.3073@dragon.hygekrogen.localhost>
	 <2cd57c900508212217c0465a3@mail.gmail.com>
	 <20050822054147.GA20546@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> On Mon, Aug 22, 2005 at 01:17:59PM +0800, Coywolf Qi Hunt wrote:
> > On 1/23/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > >
[snip]
> > > +       printk(KERN_NOTICE);
> > >         printk(linux_banner);
> >
> > Why not merge it to the same line?
> >

No reason really.

[snip]
> 
> I'm not sure if this is cleaner. The original 2-line implementation seems
> convenient. All up to you.
> 
Either way is fine by me.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
