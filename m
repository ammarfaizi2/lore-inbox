Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUREI>; Wed, 21 Feb 2001 12:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbRBURD6>; Wed, 21 Feb 2001 12:03:58 -0500
Received: from lca3183.lss.emc.com ([168.159.123.183]:32772 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S129051AbRBURDm>; Wed, 21 Feb 2001 12:03:42 -0500
Date: Thu, 22 Feb 2001 04:03:06 +1100
Message-Id: <200102211703.f1LH36W01049@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Heinz Mauelshagen <mauelshagen@sistina.com>
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
In-Reply-To: <20010221180035.N25927@athlon.random>
In-Reply-To: <20010220234219.B2023@athlon.random>
	<200102210031.f1L0VQU15564@webber.adilger.net>
	<20010221021252.A932@athlon.random>
	<200102210349.f1L3nHE03110@mobilix.atnf.CSIRO.AU>
	<20010221180035.N25927@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[LVM list removed so I don't get the nastygram]
Andrea Arcangeli writes:
> On Wed, Feb 21, 2001 at 02:49:17PM +1100, Richard Gooch wrote:
> > You definately can mknod(2) on devfs. [..]
> 
> So then why don't we simply create the VG ourself with the right
> minor number and use it as we do without devfs? We'll still have a
> global 256 VG limit this way but that's not a minor issue.

Erm, that's a good question. Since I don't know the background to this
thread, can someone fill me in on what the problem/issue is?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
