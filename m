Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSJPL7r>; Wed, 16 Oct 2002 07:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbSJPL7r>; Wed, 16 Oct 2002 07:59:47 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:58374 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262372AbSJPL7r>; Wed, 16 Oct 2002 07:59:47 -0400
Date: Wed, 16 Oct 2002 08:05:29 -0400
From: Ben Collins <bcollins@debian.org>
To: Jens Axboe <axboe@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
Message-ID: <20021016120528.GI5613@phunnypharm.org>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <20021016073154.GF4827@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016073154.GF4827@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 09:31:55AM +0200, Jens Axboe wrote:
> On Tue, Oct 15 2002, Linus Torvalds wrote:
> > 
> > A huge merging frenzy for the feature freeze, although I also spent a few
> > days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> > CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> > those off to the maintainer).
> 
> I put cdrecord rpms up here:
> 
> *.kernel.org/pub/linux/kernel/people/axboe/tools
> 
> The binary rpms are built on SuSE 8.1, there's a source rpm there too
> though. This is 1.11a37 with Linus patch that allows you do to

Can us non-rpm'ers get a tarball, please? Even an upstream tarball with
patches in the topdir would be fine.

Thanks

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
