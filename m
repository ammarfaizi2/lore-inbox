Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282002AbRKZTlB>; Mon, 26 Nov 2001 14:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282434AbRKZTjp>; Mon, 26 Nov 2001 14:39:45 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:64964 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282021AbRKZTgz>;
	Mon, 26 Nov 2001 14:36:55 -0500
Date: Mon, 26 Nov 2001 20:36:27 +0100
From: David Weinehall <tao@acc.umu.se>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011126203627.N5770@khan.acc.umu.se>
In-Reply-To: <3C028A8D.8040503@zytor.com> <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Nov 26, 2001 at 03:25:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 03:25:24PM -0200, Marcelo Tosatti wrote:
> 
> 
> On Mon, 26 Nov 2001, H. Peter Anvin wrote:
> 
> > David Weinehall wrote:
> > 
> > >>
> > >>Oh, and yes, if you settle on a naming scheme, *please* let me know
> > >>ahead of time so I can update the scripts to track it, rather than
> > >>finding out by having hundreds of complaints in my mailbox...
> > >>
> > > 
> > > I for one used the -pre and -pre-final naming for the v2.0.39-series,
> > > and I'll probably use the same naming for the final pre-patch of
> > > v2.0.40, _unless_ there's some sort of agreement on another naming 
> > > scheme. I'd be perfectly content with using the -rc naming for the
> > > final instead. The important thing is not the naming itself, but
> > > consistency between the different kernel-trees.
> > > 
> > 
> > 
> > Consistency is a Very Good Thing[TM] (says the one who tries to teach
> > scripts to understand the naming.)  The advantage with the -rc naming is
> > that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
> > -pre-final-really-i-mean-it-this-time phenomenon when the release
> > candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
> > shame in needing more than one release candidate.
> 
> Agreed. I stick with the -rc naming convention for 2.4+... 

Ok, then I'll do likewise.

Linus, Alan?


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
