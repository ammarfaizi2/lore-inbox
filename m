Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270468AbRHHMGT>; Wed, 8 Aug 2001 08:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270470AbRHHMGM>; Wed, 8 Aug 2001 08:06:12 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:35839
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S270468AbRHHMF7>; Wed, 8 Aug 2001 08:05:59 -0400
Message-ID: <3B712B48.5B0AA54@math.ethz.ch>
Date: Wed, 08 Aug 2001 14:06:32 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@dplanet.ch
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1 is 
 available.
In-Reply-To: <200108081139.f78BdTH11980@ns.caldera.de> <3B712706.A7D566F1@math.ethz.ch> <20010808135457.A13261@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Wed, Aug 08, 2001 at 01:48:22PM +0200, Giacomo Catenazzi wrote:
> >
> > Why?
> >
> > (Yes legally is wrong, and we should check case per case, but as far
> > as we can do, we should GPL as much code as possible, and we should
> > follow where possible the GPL also on non GPL code)
> 
> That's blurb.  You can just put the GPLed sources for the shipped
> stuff somewhere else on kernel.org and you're fine.  There is no
> fsckin need to have them in the same archive.

But it is too complex!
Every distribution (which ship binary kernel) should provide (at
user request) the sources. Thus every distributor should check
all kernel.org, read all the linux/Documentation files and the top
of every source files to find the extra source to ship in they
source-CD.

	giacomo

> 
>         Christoph
> 
> --
> Whip me.  Beat me.  Make me maintain AIX.
>
