Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSIPD4j>; Sun, 15 Sep 2002 23:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSIPD4j>; Sun, 15 Sep 2002 23:56:39 -0400
Received: from mnh-1-28.mv.com ([207.22.10.60]:5638 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318792AbSIPD4j>;
	Sun, 15 Sep 2002 23:56:39 -0400
Message-Id: <200209160459.XAA04288@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Daniel Phillips <phillips@arcor.de>
cc: Daniel Jacobowitz <dan@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34 
In-Reply-To: Your message of "Sun, 15 Sep 2002 21:48:51 +0200."
             <E17qfNz-00008n-00@starship> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Sep 2002 23:59:12 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@arcor.de said:
> Oh, and there is another big suckage in UML in the area of modules,
> you have to load the symbols by hand, which is just enough pain to
> make it not worth compiling things as modules in UML.

There is a nice expect script available with automates that for you.  See
http://user-mode-linux.sf.net/debugging.html, towards the bottom.

That's from Chandan Kudige, who followed that up by making UML sort of work
on Windows :-)

				Jeff

