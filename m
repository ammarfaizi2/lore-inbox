Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSBDPEr>; Mon, 4 Feb 2002 10:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289011AbSBDPEh>; Mon, 4 Feb 2002 10:04:37 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:10880 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289009AbSBDPEW>;
	Mon, 4 Feb 2002 10:04:22 -0500
Date: Mon, 4 Feb 2002 10:04:21 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18-pre7 Fixed typo that made compiling impossible
 in /net/ipv4/netfilter/ipfwadm_core.c
In-Reply-To: <20020204083831.G26676@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.30.0202041003530.2423-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Feb 2002, Harald Welte wrote:

> On Mon, Feb 04, 2002 at 02:04:58AM -0500, Calin A. Culianu wrote:
> >
> > /net/ipv4/netfilter/ipfwadm_core.c has a typo.  The MOD_*_USE_COUNT macros
> > are being used incorrectly.  Compiling was impossible as a result.
> >
> > I fixed the typos.  It's trivial, but I figured I'd submit this just to
> > make it easier for marcello to fix this...?  (this may have been submitted
> > by someone else already.. but my quick scan of the mailing list didn't
> > reveal anyone having patched this).
>
> It has already been submitted, but thanks anyway :)


Hehe I figured it would have been.. having both the properties of being
obvious and trivial.  :)


>
> > -Calin
>
>

