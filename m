Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282004AbRKZSbb>; Mon, 26 Nov 2001 13:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282010AbRKZS36>; Mon, 26 Nov 2001 13:29:58 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:706 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282004AbRKZS3I>;
	Mon, 26 Nov 2001 13:29:08 -0500
Date: Mon, 26 Nov 2001 19:29:02 +0100
From: David Weinehall <tao@acc.umu.se>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011126192902.M5770@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva> <9tu0n2$sav$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <9tu0n2$sav$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Nov 26, 2001 at 10:12:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:12:50AM -0800, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva>
> By author:    Marcelo Tosatti <marcelo@conectiva.com.br>
> In newsgroup: linux.dev.kernel
> > 
> > No. Just the -pre-final is a -pre-final. :) 
> > 
> > -pre-final basically means that this is the "candidate" release for the
> > final.
> > 
> > I could call it "candidate" or whatever (I don't really care about the
> > name).
> > 
> 
> That's what a release candidate is.  Expect the possibility that you
> might have more than one release candidate.
> 
> The -rc scheme proposed seems very clean indeed.
> 
> Oh, and yes, if you settle on a naming scheme, *please* let me know
> ahead of time so I can update the scripts to track it, rather than
> finding out by having hundreds of complaints in my mailbox...

I for one used the -pre and -pre-final naming for the v2.0.39-series,
and I'll probably use the same naming for the final pre-patch of
v2.0.40, _unless_ there's some sort of agreement on another naming 
scheme. I'd be perfectly content with using the -rc naming for the
final instead. The important thing is not the naming itself, but
consistency between the different kernel-trees.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
