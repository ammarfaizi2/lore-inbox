Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSKDXJl>; Mon, 4 Nov 2002 18:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbSKDXJl>; Mon, 4 Nov 2002 18:09:41 -0500
Received: from pc132.utati.net ([216.143.22.132]:8833 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262882AbSKDXJj> convert rfc822-to-8bit; Mon, 4 Nov 2002 18:09:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Jeff Garzik <jgarzik@pobox.com>, Werner Almesberger <wa@almesberger.net>
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Mon, 4 Nov 2002 18:16:14 +0000
User-Agent: KMail/1.4.3
Cc: dcinege@psychosis.com, andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <20021104195229.C1407@almesberger.net> <3DC6FC7C.7080105@pobox.com>
In-Reply-To: <3DC6FC7C.7080105@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211041816.14816.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 November 2002 23:02, Jeff Garzik wrote:
> Werner Almesberger wrote:
> >Rob Landley wrote:
> >>Yeah, cpio is a pain and change to use, but so is tar.
> >
> >Somebody who strogly dislikes cpio could just write wrapper accepting
> >tar-style options. Or add a --cpio option to GNU tar, that switches
> >to using the cpio format. One could even try to auto-detect the
> >format when reading :-)
> >
> >- Werner (hates cpio, but not enough)
>
> Well, FWIW, "pax" deprecates both cpio and tar.
>
> http://www.opengroup.org/onlinepubs/007904975/utilities/pax.html
>
> In theory pax turns cpio and tar into shell scripts.

I thought shell archives went out in the 1980's for security reasons...

>     Jeff

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
