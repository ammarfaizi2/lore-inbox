Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132549AbRDAU0o>; Sun, 1 Apr 2001 16:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDAU0Z>; Sun, 1 Apr 2001 16:26:25 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:6564 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S132549AbRDAU0S>;
	Sun, 1 Apr 2001 16:26:18 -0400
Organization: 
Date: Sun, 1 Apr 2001 23:22:47 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Matrox G400 Dualhead
Message-ID: <Pine.GSO.4.33.0104012313000.20758-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I solved the problem with dualhead!!!
Second head from 2.4.3 is /dev/fb2 rather than /dev/fb1.
Just had to look to the messages.
About matroxfb + X11 what I have seen is that if you use the same
resolution with the same number of colors as in X11 ,most of the times it will
work(except if I am in the login manager kdm!Then if I change to console
it will have the same screen).

P.S. Petr on the second head if I put mouse in the right-corner at the
bottom of the screen I will have a nice white border around the screen.
Also cursor blinks very strange if there is a lot of move on another
framebuffer on the first head and leaves some white blocks around.
I have used software and hardware cursor.

	Mythos


