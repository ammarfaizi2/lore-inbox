Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289925AbSAWW5a>; Wed, 23 Jan 2002 17:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSAWW5V>; Wed, 23 Jan 2002 17:57:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2714 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289970AbSAWW5O>;
	Wed, 23 Jan 2002 17:57:14 -0500
Date: Wed, 23 Jan 2002 17:57:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Jakob ?stergaard <jakob@unthought.net>,
        Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
In-Reply-To: <20020123113122.GC965@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0201231755510.19120-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jan 2002, Pavel Machek wrote:

> Can I umount filesystems below them?

If you mean filesystem it had been mounted on - sure.  Mountpoint is
not busy anymore.

