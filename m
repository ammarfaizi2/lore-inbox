Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbRCBI4l>; Fri, 2 Mar 2001 03:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbRCBI4c>; Fri, 2 Mar 2001 03:56:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53266 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130368AbRCBI4T>; Fri, 2 Mar 2001 03:56:19 -0500
Date: Fri, 2 Mar 2001 09:56:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hashing and directories
Message-ID: <20010302095608.G15061@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0103012103140.754-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0103012103140.754-100000@penguin.homenet>; from tigran@veritas.com on Thu, Mar 01, 2001 at 09:05:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	* userland issues (what, you thought that limits on the
> > command size will go away?)
> 
> the space allowed for arguments is not a userland issue, it is a kernel
> limit defined by MAX_ARG_PAGES in binfmts.h, so one could tweak it if one
> wanted to without breaking any userland.

Which is exactly what I done on my system. 2MB for command line is
very nice.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
