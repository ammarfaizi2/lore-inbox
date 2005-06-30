Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVF3XUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVF3XUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVF3XUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:20:13 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:44306 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263110AbVF3XUD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:20:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uuh20zGxjBGdF/ygKleYUxrleuFHdTHaX+cyNHkUETJiby3+xcnLB5LPm7zVVSHDeMlKPXD8uJXItISODjJOOE3d/e8/+etcmeecenO6F78MZbzFcXiuQJG98kF1qi9izioU5XQe2/0MFAzx3CB3lioNPdYjKDSTUe+Jd+A6fMA=
Message-ID: <9a874849050630162042f10062@mail.gmail.com>
Date: Fri, 1 Jul 2005 01:20:01 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
Subject: Re: reiser4 plugins
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20050627125555.GE11013@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <42BB31E9.50805@slaphack.com>
	 <1119570225.18655.75.camel@localhost.localdomain>
	 <42BB5E1A.70903@namesys.com>
	 <1119609680.17066.81.camel@localhost.localdomain>
	 <20050627091808.GC11013@nysv.org> <42BFCAE7.6070708@yahoo.com.au>
	 <20050627125555.GE11013@nysv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Markus   Törnqvist <mjt@nysv.org> wrote:
[...]
> 
> I hate to say this without digging out any URLs, but one friend
> of mine says he has a very hard time doing any networking code
> because it's too labile. Maybe that's being embettered for something
> else too?
> 
> Or the other friend who curses that the networking code is just
> crap and basically has to rewrite the code to get it working.
> Yes, I've tried to get these guys to submit their code, but they
> argue back that no one wants to see it.
> 
[...]

I'm pretty damn sure the relevant maintainers (and a bunch of people
on LKML and the netdev lists in general) would like to see patches
that improves their code.
If these friends of yours are sitting on patches that make massive
improvements to the code and they are not submitting patches then they
are not exactely helping (and I'd suspect them to just be full of BS)
- they should get their code merged instead of having to maintain it
themselves out-of-tree for ever - let the rest of us bennefit as well.
It's my experience that if you can explain the problems your patch fix
and explain well why the fix is sane, then getting your patches merged
doesn't have to be hard.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
