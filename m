Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSFCRKj>; Mon, 3 Jun 2002 13:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFCRKi>; Mon, 3 Jun 2002 13:10:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29956 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317427AbSFCRKi>; Mon, 3 Jun 2002 13:10:38 -0400
Date: Mon, 3 Jun 2002 13:13:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Pawel Kot <pkot@linuxnews.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Andre Hedrick <andre@serialata.org>
Subject: Re: Another -pre
In-Reply-To: <Pine.LNX.4.33.0206031757030.3741-100000@urtica.linuxnews.pl>
Message-ID: <Pine.LNX.4.44.0206031312550.4146-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jun 2002, Pawel Kot wrote:

> On Mon, 3 Jun 2002, Marcelo Tosatti wrote:
>
> > On Mon, 3 Jun 2002, Pawel Kot wrote:
> >
> > > On Mon, 3 Jun 2002, Marcelo Tosatti wrote:
> > >
> > > > Due to some missing network fixes and -ac merge, I'll release another -pre
> > > > later today.
> > > >
> > > > -rc should be out by the end of the week.
> > >
> > > Would you please consider merging some IDE updates before releasing
> > > 2.4.19? Current version remains unusable for me.
> > > See http://marc.theaimsgroup.com/?l=linux-kernel&m=102277249800423&w=2
> > > and followers for more detailes.
> >
> > Andre,
> >
> > Have you looked into this problem ?
>
> Yes, Andre looked into this problem. His answer was to use -ac kernels, as
> this series has the most complete IDE code. I patched the kernel with
> ide-2.4.19-p7.all.convert.10.patch from linuxdiskcert.org (with required
> changes to apply the patch) and DMA problem seems to disappear.

Andre,

Are there any other critical fixes in the -ac IDE code that is not on the
stock tree yet?

