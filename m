Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWAJTyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWAJTyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWAJTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:54:37 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:63891 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932524AbWAJTyg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:54:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rw/UI86ytD8i35vLGOzbZLUXoW5vePk20upJKbQsyq3cdUx4W7g60aX1Plx84UYFhYg/Z4vE42DFnUgWwu8HAfces0BZkJarqD9s9HWWqjn87bB7viv/s5FJ8gUUiAznv1eke2zZ2MZXVV1je8fYcEY9XJqCns1xXeXaKCnKzmM=
Message-ID: <9a8748490601101154p1938d9b7mdec66b45806a021@mail.gmail.com>
Date: Tue, 10 Jan 2006 20:54:34 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] ne2k PCI/ISA documentation: improved cross-reference.
Cc: "G.W. Haywood" <ged@jubileegroup.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060109163501.GA7029@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0512291301420.2118@mail3.jubileegroup.co.uk>
	 <9a8748490512290553g448d1e28w65dad834cd08e1a7@mail.gmail.com>
	 <Pine.LNX.4.58.0512291520250.6219@mail3.jubileegroup.co.uk>
	 <200512292149.55237.jesper.juhl@gmail.com>
	 <Pine.LNX.4.58.0601071459440.8957@mail3.jubileegroup.co.uk>
	 <20060109130655.GA4687@dmt.cnet>
	 <Pine.LNX.4.58.0601091642160.20758@mail3.jubileegroup.co.uk>
	 <20060109163501.GA7029@dmt.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> On Mon, Jan 09, 2006 at 04:46:09PM +0000, G.W. Haywood wrote:
> > Hi Marcelo,
> >
> > On Mon, 9 Jan 2006, Marcelo Tosatti wrote:
> >
> > > On Sat, Jan 07, 2006 at 03:11:40PM +0000, G.W. Haywood wrote:
> > > > From: Ged Haywood <ged@jubileegroup.co.uk>
> > > >
> > > > Improved reference to PCI ne2k support in ISA ne2k documentation.
> >
> > > Appreciate your efforts but the v2.4 tree is under deep maintenance mode
> >
> > Sorry, I didn't know.  (And evidently several other people on the LKML
> > didn't know either... :)  Does that mean that development is finished
> > on the 2.4 tree, or will it switch back to accepting patches at some
> > future time?
>
> Development is definately finished. The maintenance of the stable tree
> at this point should be done to fix critical problems.
>
> So, its accepting patches, but only for critical problems/real bugs.
>
> > There's quite a lot in the Documentation/ directory that could be
> > improved (as you probably know:).
>
> Definately - the community has concentrated efforts on the v2.6 tree
> for more than 3, 4 years.
>
> linux-2.6.14/drivers/net/Kconfig has the exact same text:
>
>     If you have a PCI NE2000 card however, say N here and Y to "PCI
>     NE2000 support", above. If you have a NE2000 card and are running on
>     an MCA system (a bus system used on some IBM PS/2 computers and
>     laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
>     below.
>
> Send a patch :)
>
Mr. Haywood already did (to LKML).
I created a 2.6 version of his patch and he submitted it to LKML -
it's not been picked up yet though.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
