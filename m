Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282514AbRKZU6B>; Mon, 26 Nov 2001 15:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282500AbRKZU55>; Mon, 26 Nov 2001 15:57:57 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:20425 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282514AbRKZU4V>;
	Mon, 26 Nov 2001 15:56:21 -0500
Date: Mon, 26 Nov 2001 21:55:47 +0100
From: David Weinehall <tao@acc.umu.se>
To: junio@siamese.dhis.twinsun.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011126215547.O5770@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva> <7v1yil1d2x.fsf@siamese.dhis.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <7v1yil1d2x.fsf@siamese.dhis.twinsun.com>; from junio@siamese.dhis.twinsun.com on Mon, Nov 26, 2001 at 12:39:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 12:39:34PM -0800, junio@siamese.dhis.twinsun.com wrote:
> >>>>> "MT" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> MT> On Mon, 26 Nov 2001, H. Peter Anvin wrote:
> >> Consistency is a Very Good Thing[TM] (says the one who tries to teach
> >> scripts to understand the naming.)  The advantage with the -rc naming is
> >> that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
> >> -pre-final-really-i-mean-it-this-time phenomenon when the release
> >> candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
> >> shame in needing more than one release candidate.
> 
> MT> Agreed. I stick with the -rc naming convention for 2.4+... 
> 
> (This is a request to maintainers of three stable trees).
> 
> While we are on the topic, could you also coordinate to keep the
> EXTRAVERSION strings consistent?  2.4.X-preN uses "-preN" but
> 2.2.X-preN uses "preN" without leading "-".

I'm using "-preN" with a leading "-", and will probably continue
doing so.


Regards: David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
