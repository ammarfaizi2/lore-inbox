Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281578AbRK0Q7X>; Tue, 27 Nov 2001 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRK0Q7N>; Tue, 27 Nov 2001 11:59:13 -0500
Received: from www.wen-online.de ([212.223.88.39]:45836 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S281504AbRK0Q7E>;
	Tue, 27 Nov 2001 11:59:04 -0500
Date: Tue, 27 Nov 2001 17:58:31 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <01112716084403.00872@manta>
Message-ID: <Pine.LNX.4.33.0111271738480.807-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, vda wrote:

> On Monday 26 November 2001 16:45, Mike Galbraith wrote:
> > On Mon, 26 Nov 2001, vda wrote:
> > > On Monday 26 November 2001 13:02, Rik van Riel wrote:
> > > > On Mon, 26 Nov 2001, Ian Stirling wrote:
> > > > > However, I for one never run a -pre kernel.
> > > > >
> > > > > I don't run -pre, because rightly or wrongly, I've got the impression
> > > > > that these get even less testing than releases.
> > > >
> > > > I think the opening sentence of your email states
> > > > the reason for that pretty well.
> > >
> > > The only way we can get good testing for new kernels is to stop using
> > > -preN prefix in development branch (2.5.x). Just increment that 'x'.
> >
> > That won't change anything except the number on the kernel.  The people
> > who you're trying to turn into bleeding edge testers (those who stay a
> > little behind [bignum]) will continue to ride the curve at the point of
> > their choosing.
>
> Yes, but they can't tell which 2.5.x is more stable just from version number.
> This way Linus will get better test coverage in 2.5.x.

Wrong.  Anybody who has been around a while will not be foxed.  Those
newcomers who haven't figured out where on the curve they want to sit
will figure it out, so I repeat.. changes nothing.

	-Mike

P.S.  I had deleted the cc list quite intentionally.... :-

