Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282013AbRKZSoo>; Mon, 26 Nov 2001 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282037AbRKZSnj>; Mon, 26 Nov 2001 13:43:39 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52488 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282039AbRKZSmr>; Mon, 26 Nov 2001 13:42:47 -0500
Date: Mon, 26 Nov 2001 15:25:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <3C028A8D.8040503@zytor.com>
Message-ID: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Nov 2001, H. Peter Anvin wrote:

> David Weinehall wrote:
> 
> >>
> >>Oh, and yes, if you settle on a naming scheme, *please* let me know
> >>ahead of time so I can update the scripts to track it, rather than
> >>finding out by having hundreds of complaints in my mailbox...
> >>
> > 
> > I for one used the -pre and -pre-final naming for the v2.0.39-series,
> > and I'll probably use the same naming for the final pre-patch of
> > v2.0.40, _unless_ there's some sort of agreement on another naming 
> > scheme. I'd be perfectly content with using the -rc naming for the
> > final instead. The important thing is not the naming itself, but
> > consistency between the different kernel-trees.
> > 
> 
> 
> Consistency is a Very Good Thing[TM] (says the one who tries to teach
> scripts to understand the naming.)  The advantage with the -rc naming is
> that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
> -pre-final-really-i-mean-it-this-time phenomenon when the release
> candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
> shame in needing more than one release candidate.

Agreed. I stick with the -rc naming convention for 2.4+... 

