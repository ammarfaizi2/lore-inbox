Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319077AbSHFMTv>; Tue, 6 Aug 2002 08:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319079AbSHFMTv>; Tue, 6 Aug 2002 08:19:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9479 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319077AbSHFMTu>; Tue, 6 Aug 2002 08:19:50 -0400
Date: Tue, 6 Aug 2002 08:32:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ben Greear <greearb@candelatech.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
In-Reply-To: <3D4F164F.2070006@candelatech.com>
Message-ID: <Pine.LNX.4.44.0208060832090.6811-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Aug 2002, Ben Greear wrote:

> Marcelo Tosatti wrote:
> > So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
> > stuff.
> >
> > 2.4.20 will be a much faster release cycle than 2.4.19 was.
>
> Two questions:  I see change logs about NAPI going in, and then
> NAPI being removed.  I assume it is removed...but maybe it will
> be back soon?

I want arguments from Davem to include NAPI. Changing the drivers is a
reason for me to _not_ want it in.

But lets see if Davem can convince me ;)

> Second:  Where is the patch?  I looked on kernel.org and didn't
> find it.  If it's going to be there shortly, that's fine, I'll
> keep checking back.

Maybe at davem's CVS repo?

