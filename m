Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272181AbRIEOPS>; Wed, 5 Sep 2001 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272182AbRIEOPJ>; Wed, 5 Sep 2001 10:15:09 -0400
Received: from caymail.com ([199.227.10.105]:20663 "HELO pop1.netcis.com")
	by vger.kernel.org with SMTP id <S272181AbRIEOOz>;
	Wed, 5 Sep 2001 10:14:55 -0400
Date: Wed, 5 Sep 2001 10:15:25 -0400 (EDT)
From: Jeremiah Johnson <miah@pop1.netcis.com>
To: volodya@mindspring.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Re[4]: 2.4.9 UDP broke?
In-Reply-To: <Pine.LNX.4.20.0109042354001.22370-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.10.10109051010220.29827-100000@pop1.netcis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ironically, the latest "stable" version of the tulip driver on:
http://sourceforge.net/projects/tulip is older than whats in 2.4.9.  I'm
willing to bet the latest "devel" is older too (they're dated June
15(devel), and February 19(stable).

-miah

On Tue, 4 Sep 2001 volodya@mindspring.com wrote:
> 
> 
> On Tue, 4 Sep 2001, Jeremiah Johnson wrote:
> 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: MD5
> > 
> > Hello volodya,
> > 
> > I found the answer to the problem today.  It has to do with a bug in
> > one of these options:
> > 
> > CONFIG_TULIP_MWI
> > CONFIG_TULIP_MMIO
> 
> Hmm, interesting. I'll check the latest version of tulip (as well as the
> one on Donald Becker's website). Did you try them out already ?
> 
>                           Vladimir Dergachev

