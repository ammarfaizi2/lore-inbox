Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRHHLz3>; Wed, 8 Aug 2001 07:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270466AbRHHLzT>; Wed, 8 Aug 2001 07:55:19 -0400
Received: from ns.caldera.de ([212.34.180.1]:50867 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270462AbRHHLzI>;
	Wed, 8 Aug 2001 07:55:08 -0400
Date: Wed, 8 Aug 2001 13:54:58 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: cate@dplanet.ch
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1 is available.
Message-ID: <20010808135457.A13261@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, cate@dplanet.ch,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200108081139.f78BdTH11980@ns.caldera.de> <3B712706.A7D566F1@math.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B712706.A7D566F1@math.ethz.ch>; from cate@math.ethz.ch on Wed, Aug 08, 2001 at 01:48:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 01:48:22PM +0200, Giacomo Catenazzi wrote:
> Christoph Hellwig wrote:
> > 
> > In article <3B712392.A7CFEEC9@math.ethz.ch> you wrote:
> > > BTW we cannot ship the generated file without the source files,
> > > because of GPL.
> > 
> > That's wrong.
> 
> Why?
> 
> (Yes legally is wrong, and we should check case per case, but as far
> as we can do, we should GPL as much code as possible, and we should
> follow where possible the GPL also on non GPL code)

That's blurb.  You can just put the GPLed sources for the shipped
stuff somewhere else on kernel.org and you're fine.  There is no
fsckin need to have them in the same archive.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
