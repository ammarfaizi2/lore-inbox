Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRCZScn>; Mon, 26 Mar 2001 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRCZScd>; Mon, 26 Mar 2001 13:32:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:11792
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132536AbRCZScY>; Mon, 26 Mar 2001 13:32:24 -0500
Date: Mon, 26 Mar 2001 10:31:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Zephaniah E. Hull" <warp@whitestar.soark.net>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Lovely crash with 2.4.2-ac24.
In-Reply-To: <20010326132833.B3920@whitestar.soark.net>
Message-ID: <Pine.LNX.4.10.10103261030570.14541-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Zephaniah E. Hull wrote:

> On Mon, Mar 26, 2001 at 09:46:54AM -0800, Andre Hedrick wrote:
> > 
> > Zephaniah,
> > 
> > Does this happen in a non-ac kernel?
> > I have not updated code since around 2.4.0, but other have.
> > You point ot a few times w/ ac18, but is there one before that which does
> > not cause this to happen?
> > 
> > The question is to gain isolation of the changes.
> 
> I'm not sure, I did not see it on 2.4.2-ac18 until I started doing a lot
> of X compiling, but I can't reproduce at will which makes this a little
> harder.
> 
> I could try 2.4.2 the current 2.4.3-pre kernels from Linus if that would
> help? (Though, as I said, it seems to happen semi-randomly, though more
> when there is heavy disk activity.)

But hardware class and vender?

> 
> Zephaniah E. Hull.
> > 
> > On Mon, 26 Mar 2001, Zephaniah E. Hull wrote:
> > 
> > > This had hit me a few times with ac18 (I'm not sure it was the same
> > > crash though) and just hit me again with ac24.
> > > 
> > > Alan cced due to it being in the ac kernels, Andre because the trace
> > > seems to point to the IDE code.
> > > 
> > > Thanks.
> > > 
> > > Zephaniah E. Hull.
> > > 
> > > -- 
> > >  PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
> > >     Keys available at http://whitestar.soark.net/~warp/public_keys.
> > >            CCs of replies from mailing lists are encouraged.
> > > 
> > > <cas> Mercury: gpm isn't a very good web browser.  fix it.
> > > 
> > 
> > Andre Hedrick
> > Linux ATA Development
> > ASL Kernel Development
> > -----------------------------------------------------------------------------
> > ASL, Inc.                                     Toll free: 1-877-ASL-3535
> > 1757 Houret Court                             Fax: 1-408-941-2071
> > Milpitas, CA 95035                            Web: www.aslab.com
> > 
> 
> -- 
>  PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
>     Keys available at http://whitestar.soark.net/~warp/public_keys.
>            CCs of replies from mailing lists are encouraged.
> 
> "Delivery anywhere in the world within thirty minutes or the second one's
>  free." - "pizza box" art atop a Minuteman ICBM silo, Paul A. Suhler, RHF
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

