Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbSJPMEm>; Wed, 16 Oct 2002 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262404AbSJPMEl>; Wed, 16 Oct 2002 08:04:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11719 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262398AbSJPMDP>;
	Wed, 16 Oct 2002 08:03:15 -0400
Date: Wed, 16 Oct 2002 14:09:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <bcollins@debian.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
Message-ID: <20021016120902.GO860@suse.de>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <20021016073154.GF4827@suse.de> <20021016120528.GI5613@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016120528.GI5613@phunnypharm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16 2002, Ben Collins wrote:
> On Wed, Oct 16, 2002 at 09:31:55AM +0200, Jens Axboe wrote:
> > On Tue, Oct 15 2002, Linus Torvalds wrote:
> > > 
> > > A huge merging frenzy for the feature freeze, although I also spent a few
> > > days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> > > CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> > > those off to the maintainer).
> > 
> > I put cdrecord rpms up here:
> > 
> > *.kernel.org/pub/linux/kernel/people/axboe/tools
> > 
> > The binary rpms are built on SuSE 8.1, there's a source rpm there too
> > though. This is 1.11a37 with Linus patch that allows you do to
> 
> Can us non-rpm'ers get a tarball, please? Even an upstream tarball with
> patches in the topdir would be fine.

The patch is called linus-cdr.diff, tar ball of 1.1a37 can be found off
fresmeat.

-- 
Jens Axboe

