Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274853AbRIUWE2>; Fri, 21 Sep 2001 18:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274855AbRIUWEK>; Fri, 21 Sep 2001 18:04:10 -0400
Received: from jive.SoftHome.net ([204.144.231.93]:50585 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S274853AbRIUWDv>;
	Fri, 21 Sep 2001 18:03:51 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Sep 2001 23:26:37 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Linux Kernel 2.2.20-pre10 Initial Impressions
Reply-to: jlmales@softhome.net
Message-ID: <3BA7D82D.21744.63CF95@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am not on the kernel mailing list.  I would appreciate being copied
in on any replies.

Ok, I finially had a chance to compile the 2.2.20-pre10 Kernel and
run it though some basic paces.  I need to do more specific A vs b
(against the 2.2.19 Kernel), but it seems there are some performance
issues.  It is seems especially obvious with Netscape 4.78.  I also
had a odd Xfree error, that may have had some relationship to the
performance issue.  I have to say at this point the issue seems
selective and not a general one, but I need to do a bit more
checking.  I cannot forsee this checking happening until this
weekend.

I seem to also observe some iteresting memory management differences
with the 2.2.20-pre10 kernel vs the 2.2.19 kernel with the Open Wall
patch.  Agian not enough day to day use logged in to give a sense. 
Then if I do sense, the challence to how to quanitify this will
follow.

Just thought you like to know.  Oh, I keep forgetting to ask, is
there any issue related to the superblock work that has been going on
in tha last few version of the 2.4 kernel and a 2.2.19 or other 2.2.x
kernel?  Only asking as seemd to have some very interesting problems
show up back after switching back from  2.4.8 kernel to the 2.2.19
kernel.


Regards,

John L. Males
Willowdale, Ontario
Canada
18 September 2001 23:26
mailto:jlmales@softhome.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBO6geeOAqzTDdanI2EQJZywCg0yllJ8HWqhQuXdDWq6aSVu5B4EgAn0la
G1uAjzOiUjSd4goAUXRk1oLI
=4K5d
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
