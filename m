Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDEDmz>; Wed, 4 Apr 2001 23:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDEDmp>; Wed, 4 Apr 2001 23:42:45 -0400
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:15496 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132552AbRDEDma>; Wed, 4 Apr 2001 23:42:30 -0400
Date: Wed, 4 Apr 2001 20:42:32 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: Mark Lehrer <mark@knm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "linux" terminal type
Message-ID: <Pine.LNX.4.31.0104042040180.1580-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Is there any documentation on ths linux console terminal type?  If
>> so, where?
>
>Maybe cryptic but the most complete documentation of the linux terminal
>and it's relatives are probably /etc/termcap and the ncurses terminfo
>database.  Aside of the code itself.

Also take a look at http://www.vt100.net . Since linux tries to emulate
the Dec vt100 at this site you will find the vt100 manuals. They are quite
good and the esc codes are well described in them.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

