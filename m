Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131273AbRCNCdr>; Tue, 13 Mar 2001 21:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRCNCdi>; Tue, 13 Mar 2001 21:33:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60048 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131272AbRCNCdY>;
	Tue, 13 Mar 2001 21:33:24 -0500
Date: Tue, 13 Mar 2001 21:32:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103140128.f2E1S3506105@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103132130220.2506-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Mar 2001, Andreas Dilger wrote:

> What about if I want to know the mountpoint (inside the filesystem)
> when it is mounted?

Which mountpoint? There can be a lot of them (quite possibly - some
of them out of the chroot jail you are in, so "any" is unlikely to
do you any good).
							Cheers,
								Al

