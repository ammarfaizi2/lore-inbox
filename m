Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRKYWxc>; Sun, 25 Nov 2001 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281185AbRKYWxX>; Sun, 25 Nov 2001 17:53:23 -0500
Received: from dsl-213-023-043-168.arcor-ip.net ([213.23.43.168]:45319 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281184AbRKYWxN>;
	Sun, 25 Nov 2001 17:53:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Wedgwood <cw@f00f.org>,
        Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Subject: Re: Journaling pointless with today's hard disks?
Date: Sun, 25 Nov 2001 23:55:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011125221418.A9672@weta.f00f.org>
In-Reply-To: <20011125221418.A9672@weta.f00f.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1688Bc-00005W-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 25, 2001 10:14 am, Chris Wedgwood wrote:
> On Sat, Nov 24, 2001 at 02:03:11PM +0100, Florian Weimer wrote:
> Now, since EMC, NetApp, Sun, HP, Compaq, etc. all have products which
> presumable depend on this behavior, I don't think it's going to go
> away, it perhaps will just become important to know which drives are
> brain-damaged and list them so people can avoid them.
> 
> As this will affect the Windows world too consumer pressure will
> hopefully rectify this problem.

Andre Hedrik has put together a site with exactly this intention, check out:

    http://linuxdiskcert.org/

Of course, there's a lot of hard work between here and having a useful 
database, but, hey, well begun and all that...

According to Andre:

"the requirements are they apply a patch run a series of tests and then I 
will submit to the OEM for rebutal and if there is no resolution the drive 
and the test procedure on how to reproduce the error will be posted"

--
Daniel
