Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRITSQg>; Thu, 20 Sep 2001 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274589AbRITSQQ>; Thu, 20 Sep 2001 14:16:16 -0400
Received: from matav-3.matav.hu ([145.236.252.34]:63765 "EHLO
	Milos.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S274586AbRITSQJ>; Thu, 20 Sep 2001 14:16:09 -0400
Date: Thu, 20 Sep 2001 20:12:48 +0200 (CEST)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: <narancs@helka>
To: <linux-xfs@oss.sgi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: XFS to main kernel source
Message-ID: <Pine.LNX.4.33.0109201937220.21430-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all!

First of all, I want to thank you the great job you do to Linux!
Linux is a great OS/kernel and XFS is my favorite FS since I tried it.

Problems:

When will be the XFS patch integrated to main tree?

I'm really fed up with trying to get linux-2.4.9 + acXX or preXX + xfs
together.

I'm using XFS from notebooks to DB servers and it's really hard to compile
a good and fresh kernel.

Now I currently have some machines like 2.4.10-pre-xfs and so on.
I want to have some features from -ac tree and/or the latest pre kernels,
but patching fails, I have to do things by hand with the .rej files, and I
can make mistakes so I have a kernel in the notebook which handles the
ps/2 mouse in X very bad (the cursor jumps on big use I/O or CPU, maybe
sy with the interrupts is wrong.)

I know it takes time and resources, but if once XFS is in the main tree as
Reiser is in (maybe other folks wants ext3 to get in too) -
this problem will be eleminated, and I could use ie. the usb/SCSI module
hp scanner with xfs and dvd playback too.

thanks

 -------------------------
Narancs v1
IT Security Administrator

"Security of information is an illusion.
What is in one's mind gets into the collective consciousness (akasha),
so that can be read with meditation ;-) You don't have to hack.
Just 'remember'! You're the one."

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuqMaMACgkQGp+ylEhMCIU1ywCfT1PRsEKeULNyptmQqMawsY9Q
d3AAnAzHagKVkiX1JPjfebuIUicC+Mr/
=kvPu
-----END PGP SIGNATURE-----

