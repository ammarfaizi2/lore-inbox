Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSLVBqc>; Sat, 21 Dec 2002 20:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLVBqc>; Sat, 21 Dec 2002 20:46:32 -0500
Received: from [216.179.95.39] ([216.179.95.39]:16655 "EHLO mail.srealm.net.au")
	by vger.kernel.org with ESMTP id <S264697AbSLVBqb>;
	Sat, 21 Dec 2002 20:46:31 -0500
From: "Preston A. Elder" <prez@goth.net>
Organization: Gothic Networks
To: John Bradford <john@grabjohn.com>, vojtech@suse.cz (Vojtech Pavlik)
Subject: Re: Fw: PROBLEM: Keyboard not found, but it exists!
Date: Sat, 21 Dec 2002 20:54:29 -0500
User-Agent: KMail/1.5
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
References: <200212211951.gBLJpREc001843@darkstar.example.net>
In-Reply-To: <200212211951.gBLJpREc001843@darkstar.example.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212212054.31702.prez@goth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Well, I upgraded the kernel (the old one was a 2.4.18, with a crapload of 
patches applied, the new one is actually a 2.4.19 kernel).  In short, the 
problem persists under v2.4.19.  And from the changelog, I can't see any 
changes done to this fix for 2.4.20.

It still jumps back and forth with time, and the keyboard (and mouse) are both 
still unresponsive.  I can try 2.4.20 if you think it will change anything 
over 2.4.19.  Otherwise, are there any other suggestions you can make as to 
what I can try?  I'm not as worried about the keyboard/mouse since its a 
server, and I usually ssh to it, however the 'time warp' situation (it 
jumping ahead in time, and then back again) is much more destructive to the 
applications I run on the server.

Also, is there any way to know if it activated the workaround or not?  I don't 
see anything special in my boot dmesg.  I can send the boot dmesg file (my 
system saves it immediately after boot) and my .config file to anyone who 
thinks they might get some useful information out of it.  I'd rather not have 
to go out and buy a new motherboard for this.

Thanks in advance,

- -- 
PreZ
Systems Administrator
GOTH.NET

Goth Code '98:   tSKeba5qaSabsaaaGbaa75KAASWGuajmsvbieqcL4BaaLb3F4
                 nId5mefqmDjmmgm#haxthgzpj4GiysNkycSRGHabiabOkauNSW

GOTH.NET - http://www.goth.net
Free online resource for the gothic community.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+BRtVuULtzKdGMboRAteLAJ92Wicv05G+PT3GAvHa1LUCSZtFmACgs2Az
+j6zBGa81RboJRituL4Vf0Y=
=xulE
-----END PGP SIGNATURE-----

