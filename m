Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbRLDTac>; Tue, 4 Dec 2001 14:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283288AbRLDT3P>; Tue, 4 Dec 2001 14:29:15 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:49587 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282910AbRLDT2B>;
	Tue, 4 Dec 2001 14:28:01 -0500
Date: Tue, 4 Dec 2001 20:27:46 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= 
	<raul@viadomus.com>,
        linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de,
        hch@caldera.de, kaos@ocs.com.au, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204202746.G360@khan.acc.umu.se>
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com> <20011204194652.F360@khan.acc.umu.se> <20011204134320.P16578@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011204134320.P16578@thyrsus.com>; from esr@thyrsus.com on Tue, Dec 04, 2001 at 01:43:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 01:43:20PM -0500, Eric S. Raymond wrote:
> David Weinehall <tao@acc.umu.se>:
> > Yeah, let's lose the dependencies on perl, make, awk, sed, ld, ar,
> > nm, strip, objcopy, objdump, depmod, grep, xargs, find, gzip,
> > wish, tcl/tk and possibly others. That'd surely shave a lot of diskspace
> > off my buildsystem. It's not like I use any of them for anything else...
> 
> I'm going to remove a few of these.

You know, I _was_ ironic about not needing most of those...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
