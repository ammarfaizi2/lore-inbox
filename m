Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268573AbRG3MsP>; Mon, 30 Jul 2001 08:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268576AbRG3MsG>; Mon, 30 Jul 2001 08:48:06 -0400
Received: from mx1.nameplanet.com ([62.70.3.31]:45323 "HELO mx1.nameplanet.com")
	by vger.kernel.org with SMTP id <S268573AbRG3Mrv>;
	Mon, 30 Jul 2001 08:47:51 -0400
Date: Mon, 30 Jul 2001 16:41:12 +0200 (CEST)
From: Ketil Froyn <ketil@froyn.com>
X-X-Sender: <ketil@ketil.np>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010729112810.C9109@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33.0107301637310.991-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, Matthias Andree wrote:

> On Sat, 28 Jul 2001, Mike Touloumtzis wrote:
>
> > You are blurring the boundaries between "undocumented behavior" and
> > "OS-specific behavior".  fsync() on a directory to sync metadata is a
> > defined (according to my copy of fsync(2)), Linux-specific behavior.
> > It is also very reasonable IMHO and in keeping with the traditional
> > Unix notion of directories as lists of files.

> > http://www.google.com/search?q=autoconf
> >
> > Writing portable Unix software has always meant some degree
> > of system-specific accomodation.  It's a bummer but it's life;
> > otherwise Unix wouldn't evolve.
>
> How can autoconf figure if you need to fsync() the directory?

Simple! Grep the fsync(2) manpage ;)

Ketil the joker

