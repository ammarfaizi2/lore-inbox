Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTLAJpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTLAJpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:45:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15078 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262695AbTLAJpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:45:44 -0500
Date: Mon, 1 Dec 2003 10:45:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Nathan Scott <nathans@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-ID: <20031201094505.GL6454@suse.de>
References: <20031201062052.GA2022@frodo> <20031201092446.GK6454@suse.de> <3FCB0D6A.3030503@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCB0D6A.3030503@stesmi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01 2003, Stefan Smietanowski wrote:
> Jens Axboe wrote:
> 
> >On Mon, Dec 01 2003, Nathan Scott wrote:
> >
> >>Hi Marcelo,
> >>
> >>Please do a
> >>
> >>	bk pull http://xfs.org:8090/linux-2.4+coreXFS
> >>
> >>This will merge the core 2.4 kernel changes required for supporting
> >>the XFS filesystem, as listed below.  If this all looks acceptable,
> >>then please also pull the filesystem-specific code (fs/xfs/*)
> >>
> >>	bk pull http://xfs.org:8090/linux-2.4+justXFS
> >
> >
> >Where can these be found as a unified diff? It's quite bothersome to
> >have to pull a changeset just to review it (cloning a kernel tree
> >first), not to mention space intensive.
> >
> 
> There was a mail announcing split-patches for 2.4.23 five hours before
> this mail. The mail was from Keith Owens but here's the link from it:
> 
> ftp://oss.sgi.com/projects/xfs/patches/2.4.23 for the 2.4.23 patches.

Great, thanks.

-- 
Jens Axboe

