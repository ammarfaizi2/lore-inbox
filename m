Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283444AbRLDUGn>; Tue, 4 Dec 2001 15:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283368AbRLDUE6>; Tue, 4 Dec 2001 15:04:58 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:26549 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S283389AbRLDUDn>;
	Tue, 4 Dec 2001 15:03:43 -0500
Date: Tue, 4 Dec 2001 21:03:34 +0100
From: David Weinehall <tao@acc.umu.se>
To: Dave Jones <davej@suse.de>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204210334.J360@khan.acc.umu.se>
In-Reply-To: <20011204204822.H360@khan.acc.umu.se> <Pine.LNX.4.33.0112042051590.7110-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0112042051590.7110-100000@Appserv.suse.de>; from davej@suse.de on Tue, Dec 04, 2001 at 08:53:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 08:53:11PM +0100, Dave Jones wrote:
> On Tue, 4 Dec 2001, David Weinehall wrote:
> 
> > "So anyone happy with an older distro that didn't ship gcc-2.95.x, x > 2
> > gets screwed when they want to build a newer kernel. Nice."
> 
> The difference being that recommended compiler versions don't
> change midway through a stable series. Neither should any other
> part of the buildtools.

AFAIK, changes to the required versions of userland-tools wouldn't
during a stable release happen ever-so-often. I can agree that it
wouldn't be ideal to introduce a completely new requirement, though.

A C-version of CML2-configurator would be a nice solution here.

But, I'm fairly confident that Marcello will make the right decisions
on his own.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
