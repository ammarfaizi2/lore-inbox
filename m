Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSDTVHt>; Sat, 20 Apr 2002 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSDTVHs>; Sat, 20 Apr 2002 17:07:48 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:58253 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S312317AbSDTVHs>;
	Sat, 20 Apr 2002 17:07:48 -0400
Date: Sat, 20 Apr 2002 17:07:47 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420170747.B14186@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 11:02:04PM +0200, Daniel Phillips wrote:
> Martin Dalecki's IDE patch, gosh, look at all the fun.  It's a non-BK
> patch, let's see if there's a pattern.  Hmm, the next bushy one is "[PATCH]
> zerocopy NFS updated", descending from a traditional patch set.  The next
> one, "[PATCH] IDE TCQ #4" is also a traditional patch.  Hmm, no bitkeeper
> patches showing up yet, I don't think I need to go on.
> 
> There is a clear inverse relationship between the bk-ness of a patch and
> the extent to which it's discussed on lkml.  I don't know what to read into
> that, but it does seem to lend credence to the idea that the bitkeeper
> style of working is not compatible with the idea of community discussion.

Concrete examples, please?

Which patches are the stealth patches?

	Jeff


