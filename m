Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281455AbRKZDvE>; Sun, 25 Nov 2001 22:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281460AbRKZDuz>; Sun, 25 Nov 2001 22:50:55 -0500
Received: from ausmac.net ([203.12.68.15]:15270 "HELO ausmac.net")
	by vger.kernel.org with SMTP id <S281455AbRKZDus>;
	Sun, 25 Nov 2001 22:50:48 -0500
Date: Mon, 26 Nov 2001 14:50:43 +1100 (EST)
From: Grant Bayley <gbayley@ausmac.net>
To: <linux-kernel@vger.kernel.org>
Subject: A Documentation suggestion (fwd)
Message-ID: <Pine.BSO.4.33.0111261450030.28740-100000@ausmac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I'm not on list due to volume; please reply privately)

---------- Forwarded message ----------
Date: Mon, 26 Nov 2001 14:44:39 +1100 (EST)
From: Grant Bayley <gbayley@ausmac.net>
To: Alan.Cox@linux.org, torvalds@transmeta.com
Subject: A Documentation suggestion

Hi Alan, Linus,

Just wondering if this is the right place to start...

I've been poking around in the Linux Kernel source for some time, and I've
always been a bit mystified by the layout of the Documentation directory.
Not so much the contents of it, but wondering why the layout is like it
is.

Now, without further ado, I've describe what I've done about it.

>From the top level 00-INDEX file:
---------------------------------

This is a brief list of all the files and directories in ./Documentation
and what they contain.  The layout of this directory closely mirrors
that of the Linux kernel itself, and should act as an encouragement
to developers to store documentation about their drivers etc. in
the appropriate directories.

Files kept at the top level of the Documentation hierarchy are
prepended with README- to emphasise the importance of them.

Please try and keep any additional descriptions small enough to fit
on one line.

---------------------------

To have a look at the structure and to grab a tarball of the directory,
have a squiz here:

	http://orbital.wiretapped.net/linux/

The only changes that have been made to the files themselves is correction of
a typo in one file and renaming of several others to make the contents of
the file more obvious from reading the name (ie pci.txt ->
pci-driver-development.txt, pci.txt -> pci-power-management.txt).

Hoping you'd be interested in using such a Documentation directory layout,

Grant

-------------------------------------------------------
Grant Bayley                         gbayley@ausmac.net
-Admin @ AusMac Archive, Wiretapped.net, 2600 Australia
 www.ausmac.net   www.wiretapped.net   www.2600.org.au
-------------------------------------------------------

