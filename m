Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSIPEDg>; Mon, 16 Sep 2002 00:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318795AbSIPEDg>; Mon, 16 Sep 2002 00:03:36 -0400
Received: from dsl-213-023-020-026.arcor-ip.net ([213.23.20.26]:31877 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318793AbSIPEDf>;
	Mon, 16 Sep 2002 00:03:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jeff Dike <jdike@karaya.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 06:05:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Jacobowitz <dan@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200209160459.XAA04288@ccure.karaya.com>
In-Reply-To: <200209160459.XAA04288@ccure.karaya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qn94-0000GX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 06:59, Jeff Dike wrote:
> phillips@arcor.de said:
> > Oh, and there is another big suckage in UML in the area of modules,
> > you have to load the symbols by hand, which is just enough pain to
> > make it not worth compiling things as modules in UML.
> 
> There is a nice expect script available with automates that for you.  See
> http://user-mode-linux.sf.net/debugging.html, towards the bottom.
> 
> That's from Chandan Kudige, who followed that up by making UML sort of work
> on Windows :-)

In addition, there is a gdb hacker the thread who has been thinking a
little about nonsucky ways of doing it.  You might want to kick around
some ideas with Daniel, some cute way of passing events.

-- 
Daniel
