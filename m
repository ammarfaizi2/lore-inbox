Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290209AbSAORr1>; Tue, 15 Jan 2002 12:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290212AbSAORrU>; Tue, 15 Jan 2002 12:47:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32231 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290209AbSAORrK>;
	Tue, 15 Jan 2002 12:47:10 -0500
Date: Tue, 15 Jan 2002 12:47:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020115172729.GE7030@vitelus.com>
Message-ID: <Pine.GSO.4.21.0201151233120.4339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jan 2002, Aaron Lehmann wrote:

> On Mon, Jan 14, 2002 at 07:17:46PM +0000, Alan Cox wrote:
> > Not generally found in your grandmothers PC
> 
> What kind of an argument is this?!? Linux developers used to care
> about portability to and performance on non-x86 platforms.

<rant>

Guys, could you lay off whatever the fuck you are smoking?  And
I mean everybody involved.

*	autoconfig is part of ESR's wet dream.  Ignore him and he'll go away.
*	Aunt Tillie and her magical mistery whorehouse <<--->>
*	performance problems with modules are real, need to be solved and
	can be solved.
*	disabling module loading doesn't buy any security.
*	it's easy to make irrevertible disabling modules _after_ boot.
*	initramfs is independent from modules
*	it is _not_ initrd or an analog
*	it doesn't involve a shitload of extra files
*	it removes tons of crap from kernel
*	it allows to simplify build process and get rid of quite a few sources
	of bugs, _if_ performance problems with modules are solved

Now could we fscking drop these threads?  Or at least take care to separate
myths from reality before posting more crap.

</rant>

