Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262153AbSJGSiW>; Mon, 7 Oct 2002 14:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbSJGSiW>; Mon, 7 Oct 2002 14:38:22 -0400
Received: from barrichello.cs.ucr.edu ([138.23.169.5]:49100 "HELO
	barrichello.cs.ucr.edu") by vger.kernel.org with SMTP
	id <S261726AbSJGSiV>; Mon, 7 Oct 2002 14:38:21 -0400
Mailbox-Line: From jtyner@cs.ucr.edu  Mon Oct  7 11:43:56 2002
Date: Mon, 7 Oct 2002 11:43:55 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: <video4linux-list@redhat.com>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <kraxel@bytesex.org>
Subject: Re: Vicam/3com homeconnect usb camera driver
In-Reply-To: <20021006210629.GB387@elf.ucw.cz>
Message-ID: <Pine.LNX.4.30.0210071136290.10476-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How is this different from 3comhc.c from sourceforge?

Lots of little fixes, speed and memory allocation improvements and
generally more understandable (in my opinion). The one I've written
actually implements an asynchronous send/receive and decode so
the camera works a bit faster.

I had actually been developing this driver in parallel with the
sourceforge guys before I found out about them. I combined their work with
mine to finish the driver.

See these two threads. The first provides a little more background and the
second is the thread that you replied to.

http://marc.theaimsgroup.com/?t=103344771400001&r=1&w=2
http://marc.theaimsgroup.com/?t=103370436400001&r=1&w=2

Thanks,
John

