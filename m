Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbTFMQmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTFMQmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:42:52 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:17668 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265435AbTFMQmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:42:51 -0400
Date: Fri, 13 Jun 2003 17:56:35 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Real multi-user linux
In-Reply-To: <20030613140111.34979.qmail@web12901.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0306131713340.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> John Bradford <john@grabjohn.com> skrev:
> 
> > This idea has come up before, have a look at:
> >  http://marc.theaimsgroup.com/?.....
> 
> Thank you for providing these references.  Especially
> the first thread discusses some thoughts I had, too. 
> 
> To summarize: People have thought about of one linux
> box directly supporting multiple (X-)consoles before.
> But this is not possible as of now, because X would
> have to be told to stop switching consoles and because
> the kernel cannot activate more than one console at
> one time. Additionately, multiple video cards may
> require mappings into the same memory area for certain
> functions. Some people have started to work on  a
> solution, but these projects were orphaned. 

Not true. Your project has just finished it first stable 
release. Its just we are going commerical with this product.
We even have a modified distro to handle such a system. 
Yes you have to do special modifications to make 
multi-desktop systems work. 

> My motivation is simply a private one.  I have a
> P3-866 with 1.5G RAM and a scsi raid here which serves
> its own console and an old P133 as X terminal.
> Although this machine is already some kind of
> outdated, it has plenty of power to serve two users
> with one KDE session each. 
> 
> I started to think about this, because the P133 died
> away due to a failing processor fan. Although
> replacing the whole machine with a similar one
> probably is cheaper than a good usb keyboard and
> mouse, it is also a question of comfort. No waiting
> for the terminal to boot up, no double administration,
> less power consumption, less space needed and so on. 
> 
> Although I have some C/C++ expirience, I have
> absolutely no clues about kernel and or X internals,
> so I guess I have to forget this for now. 

   It has been done. I have a system at home running a 
multi-desktop system. I have a 2 user system and my 
partner in code developement, Aivil, has a 3 person
multi-desktop system working. 
   Now that we have a working product we can go to the 
next stage. Finding customers to sell it to. This weekend
I'm getting together with a few sales guys to discuss this.
   As for the potential of this. Its large. With Gnome/KDE
and OpenOffice running for 3,4 or more people at the same
time out of one box will be a enormous cost reducer for 
any business. You coudl even do Wine to run MS apps but I 
don't know what the legal ramifactions of that would be.
As a business we wouldn't do it out of fear of being sued.
    The next stage will be non PC boards supporting more than
one graphics display output. Every now and then you see such a
board. I seen a 8 graphics chip board with 8 video outputs. 
Embedded devices that open like a wallet with a display on each 
side. Multiuser game consoles would be really cool. Its going to 
be a fun future.
 

