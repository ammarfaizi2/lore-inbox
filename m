Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274554AbRITQF6>; Thu, 20 Sep 2001 12:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274553AbRITQFt>; Thu, 20 Sep 2001 12:05:49 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:53244 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274554AbRITQFm>; Thu, 20 Sep 2001 12:05:42 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 20 Sep 2001 10:05:57 -0600
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBMs LVM?
Message-ID: <20010920100557.Z14526@turbolinux.com>
Mail-Followup-To: Christoph Hellwig <hch@ns.caldera.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109142155.f8ELtVi03827@shay.ecn.purdue.edu> <20010920135717.A11737@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920135717.A11737@caldera.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2001  13:57 +0200, Christoph Hellwig wrote:
> Anyway, I will get my design for improved block device stacking and unified
> partition discovery back from the attic and implement a protopy ontop of
> the bio patchset.  I'll Cc my ennouncement to evms-devel, you're free to
> layer ontop if you want.

Just FYI (in case you haven't seen it) the LVM folks are working on
something like this in their "LVM2" repository.  I've been seeing
the CVS commit messages, but have not actually taken a look at the
code yet, so I can't comment on it but it may save you some effort.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

