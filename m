Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUGGBMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUGGBMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 21:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUGGBMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 21:12:25 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:13755 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S264788AbUGGBMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 21:12:22 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Redeeman <lkml@metanurb.dk>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Date: Tue, 6 Jul 2004 18:12:23 -0700
User-Agent: KMail/1.6.82
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl> <1089160973.903.1.camel@localhost>
In-Reply-To: <1089160973.903.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407061812.24526.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to sound mean about this. But either you prove your claim with benchmarks 
in a controlled enviroment ( that means in a private network ), or you stop 
trolling and complaining. The linux kernel is a free piece of software, if 
you don't like one version of it, then feel free to use some earlier version. 
Otherwise please stop. 

Matt H.


On Tuesday 06 July 2004 5:42 pm, Redeeman wrote:
> On Tue, 2004-07-06 at 15:30 -0400, Horst von Brand wrote:
> > Redeeman <lkml@metanurb.dk> said:
> > > On Mon, 2004-07-05 at 17:54 -0700, Matt Heler wrote:
> > > > Ok first take benchmarks ( use wget ), and secondly results from the
> > > > internet vary day by day , hour to hour , minute by minute. Don't
> > > > expect all sites on the internet to be the same speed, or even stay
> > > > the same speed for that matter. For more accurate benchmark results
> > > > setup a personal server on your own private network and benchmark
> > > > http trasnfers using different kernels.
> > >
> > > i am aware of this, however, what i use to benchmark is kernel.org, as
> > > i can see they have alot bandwith free.
> >
> > How do you know that?
>
> how i know? i dont think anyone in the matter of seconds begin to use
> the spare ~800mbit/s of bandwith they do not use when i try, (according
> to info from bwbar on kernel.org)
>
> > > if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> > > with 200kb/s
> >
> > Trafic shaping somewhere along the route? Much more load on HTTP than
> > FTP? Are they the very same machines? Under the exact same load? Are the
> > servers written with the same care? Are the clients?
> >
> > > also, the gnu ftp, where i took gcc3.4.1, it gave me 200kb/s
> >
> > Ditto.
> >
> > Unless you set up something where there aren't dozens of unknown
> > variables and a hundred or so that you have got no chance at all to even
> > guess what their values/effects are...
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
