Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279512AbRKIHM7>; Fri, 9 Nov 2001 02:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279580AbRKIHMu>; Fri, 9 Nov 2001 02:12:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13734 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279512AbRKIHMl>;
	Fri, 9 Nov 2001 02:12:41 -0500
Date: Fri, 9 Nov 2001 02:12:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Andrew Morton <akpm@zip.com.au>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011108235632.D907@lynx.no>
Message-ID: <Pine.GSO.4.21.0111090210060.9938-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Nov 2001, Andreas Dilger wrote:

> It may be possible to hack the test data into ext2 by creating a filesystem
> with the same number of block groups as the test FFS filesystem with the
> Smith workload.  It may also not be valid for our needs, as we are playing
> with the actual group selection algorithm, so real pathnames may give us
> a different layout.

Umm...  What was the block and fragment sizes in their tests?

