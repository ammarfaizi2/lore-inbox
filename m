Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131083AbQLNFqw>; Thu, 14 Dec 2000 00:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQLNFqm>; Thu, 14 Dec 2000 00:46:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50585 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131083AbQLNFqc>;
	Thu, 14 Dec 2000 00:46:32 -0500
Date: Thu, 14 Dec 2000 00:15:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chip Salzenberg <chip@valinux.com>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001213205219.M864@valinux.com>
Message-ID: <Pine.GSO.4.21.0012140000330.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chip Salzenberg wrote:

> As long as names are to be created, or at least understood, by humans,
> there will be some limit on *usable* length.  In my experience, 255 is
> above that limit, but 30 is below it.  And I cut my teeth on a system
> that had exactly that length limitation (UNOS).

Maybe... I definitely agree that 14 is below the limit, but 30... Hell knows,
from what I see on the box I'm using right now it seems to fall into several
cathegories:
	* Very-Long-And-Verbose-Named-HOWTO.html
	* manpages for X and Tcl functions with obscenely long names
	* *.deb and corresponding *.diff.gz and *.dsc
	* var/state/apt/lists/*
	* ghostscript maps
Hmm... Cutoff seems to sit somewhere around 45 - above that there are only
apt-get droppings and they definitely are over the top. Dunno, you may be
right, but looks like I never had a need to create anything that long.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
