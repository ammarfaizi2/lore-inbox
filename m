Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRCHFf0>; Thu, 8 Mar 2001 00:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRCHFfR>; Thu, 8 Mar 2001 00:35:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48592 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131275AbRCHFfH>;
	Thu, 8 Mar 2001 00:35:07 -0500
Date: Thu, 8 Mar 2001 00:34:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ben Greear <greearb@candelatech.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ?
 (No
In-Reply-To: <3AA71B5C.5AD8661E@candelatech.com>
Message-ID: <Pine.GSO.4.21.0103080027150.5588-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Ben Greear wrote:

> However, messing with the hdparms options can do random things, at
> least from my perspective as a user:  It may bring exciting new performance
> to your system, and it may subtly, or not so, corrupt your file system.

It's root-only. If you run unfamiliar stuff as root without thorough
RTFM or choose to ignore "use with extreme caution" contained in the
manpage - hdparm is the least of your problems. Think of it as evolution
in action...
							Cheers,
								Al

