Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283630AbRLDOo2>; Tue, 4 Dec 2001 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283135AbRLDOnO>; Tue, 4 Dec 2001 09:43:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:21916 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S283656AbRLDNly>;
	Tue, 4 Dec 2001 08:41:54 -0500
Date: Tue, 4 Dec 2001 14:41:40 +0100
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011204144140.E360@khan.acc.umu.se>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEENCECAA.znmeb@aracnet.com> <E16BBsg-0001Ny-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16BBsg-0001Ny-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 04, 2001 at 09:28:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 09:28:49AM +0000, Alan Cox wrote:
> On Mon, Dec 03, 2001 at 06:31:38AM -0800, M. Edward Borasky wrote:
> > What I'm trying to establish here is that if ALSA is to become the
> > main-stream Linux sound driver set, it's going to need to support --
> > *fully* support -- the top-of-the-line sound cards like my M-Audio
> > Delta 66.
> 
> Not really. The number of people who actually care about such cards is
> close to nil. What matters is that the API can cleanly express what
> the Delta66 can do, and that you can write a driver for it under ALSA
> without hacking up the ALSA core.

Indeed. And I'm sure the ALSA-team would be delighted and fully willing
to write a working driver, if mr Borasky donated an M-Audio Delta 66
together with full documentation to them...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
