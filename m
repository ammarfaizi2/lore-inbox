Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSAUTfy>; Mon, 21 Jan 2002 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287991AbSAUTfo>; Mon, 21 Jan 2002 14:35:44 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:43710 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S287940AbSAUTf0>;
	Mon, 21 Jan 2002 14:35:26 -0500
Date: Mon, 21 Jan 2002 20:34:44 +0100
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Reid Hekman <reid.hekman@ndsu.nodak.edu>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020121203443.K1735@khan.acc.umu.se>
In-Reply-To: <1011610422.13864.24.camel@zeus> <E16SkGH-0000Ut-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16SkGH-0000Ut-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 21, 2002 at 07:37:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 07:37:45PM +0000, Alan Cox wrote:
> > That errata lists all Athlon Thunderbirds as affected and all Athlon
> > Palominos except for stepping A5. 
> > 
> > Regardless of specific errata listings, will future workarounds be
> > enabled based on cpuid or via a test for the bug itself?
> 
> That problem shouldnt be hitting Linux x86. I don't know about the
> Nvidia module but the base kernel shouldnt hit an invlpg on 4Mb pages

The reference to you in the /.-article is the usual /.-bullshit, I
gather?!


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
