Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279805AbRK0OLu>; Tue, 27 Nov 2001 09:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279790AbRK0OLk>; Tue, 27 Nov 2001 09:11:40 -0500
Received: from [195.66.192.167] ([195.66.192.167]:29203 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279814AbRK0OLd>; Tue, 27 Nov 2001 09:11:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: Kernel Releases
Date: Tue, 27 Nov 2001 16:08:44 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0111261807570.489-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0111261807570.489-100000@mikeg.weiden.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01112716084403.00872@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 16:45, Mike Galbraith wrote:
> On Mon, 26 Nov 2001, vda wrote:
> > On Monday 26 November 2001 13:02, Rik van Riel wrote:
> > > On Mon, 26 Nov 2001, Ian Stirling wrote:
> > > > However, I for one never run a -pre kernel.
> > > >
> > > > I don't run -pre, because rightly or wrongly, I've got the impression
> > > > that these get even less testing than releases.
> > >
> > > I think the opening sentence of your email states
> > > the reason for that pretty well.
> >
> > The only way we can get good testing for new kernels is to stop using
> > -preN prefix in development branch (2.5.x). Just increment that 'x'.
>
> That won't change anything except the number on the kernel.  The people
> who you're trying to turn into bleeding edge testers (those who stay a
> little behind [bignum]) will continue to ride the curve at the point of
> their choosing.

Yes, but they can't tell which 2.5.x is more stable just from version number.
This way Linus will get better test coverage in 2.5.x.

Those who need stability can read lkml and figure out which 2.5.x was 
'glitchless' :-) or stick with 2.4.x
--
vda
