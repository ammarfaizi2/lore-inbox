Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289550AbSBEPOQ>; Tue, 5 Feb 2002 10:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289577AbSBEPN7>; Tue, 5 Feb 2002 10:13:59 -0500
Received: from mustard.heime.net ([194.234.65.222]:41123 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289550AbSBEPNp>; Tue, 5 Feb 2002 10:13:45 -0500
Date: Tue, 5 Feb 2002 16:13:42 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: opening a bzImage?
In-Reply-To: <Pine.LNX.4.33.0202051005500.20417-100000@northface.intercarve.net>
Message-ID: <Pine.LNX.4.30.0202051613010.13539-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They don't even want to give me the source. I keep trying to force them
the legal way, as they're breaking the GPL

On Tue, 5 Feb 2002, Drew P. Vogel wrote:

> Ahh, just a guess. May I ask why you need to know the contents of the
> image? The way it sounds is that you are performing a service for the
> company. If you are, I don't see any reason they would object to giving
> you the .config.
>
> --Drew Vogel
>
> On Tue, 5 Feb 2002, Roy Sigurd Karlsbakk wrote:
>
> >> I've never tried this, but could you do something like
> >>
> >> bunzip2 -c bzImage > zImage && ar -t zImage
> >
> >Doesn't work
> >
> >bzcat: dist/images/kernel-nfs is not a bzip2 file.
> >
> >
> >--
> >Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> >
> >Computers are like air conditioners.
> >They stop working when you open Windows.
> >
> >
>
>
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

