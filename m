Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292222AbSBYUk4>; Mon, 25 Feb 2002 15:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292245AbSBYUkr>; Mon, 25 Feb 2002 15:40:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:27144 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292222AbSBYUkg>; Mon, 25 Feb 2002 15:40:36 -0500
Date: Mon, 25 Feb 2002 16:31:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: DevilKin <DevilKin-LKML@blindguardian.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18
In-Reply-To: <20020225200618.0FAE82069E@eos.telenet-ops.be>
Message-ID: <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, DevilKin wrote:

> On Monday 25 February 2002 20:18, Marcelo Tosatti wrote:
> > On Mon, 25 Feb 2002, Holzrichter, Bruce wrote:
> > > > Ok, DAMN. I missed the -rc4 patch in 2.4.18. Real sorry about that.
> > > >
> > > > 2.4.19-pre1 will contain it.
> > >
> > > Should 2.4.18 final get a -dontuse tag or something?
> >
> > No. A "-dontuse" tag should be only used when the kernel can cause damage
> > in some way.
> >
> > The patch which I missed only breaks static apps on _some_ architectures
> > (not including x86).
> >
> > > Some people may get confused grabbing 2.4.18 and not getting the fixes
> > > that went into rc-4? Just a thought...
> >
> > I already changed ftp.kernel.org's changelog adding:
> >
> > "Update: The SET_PERSONALITY fix in rc4 has _not_
> > been included in the final 2.4.18 by mistake."
> >
> > I guess thats enough.
> 
> Wouldn't it be easier just to make a new 2.4.18 with the patch applied?
> 
> Just to make all our lives a bit easier...

Having two 2.4.18's is a bit of a mess for the ftp.kernel.org mirroring
system.



