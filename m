Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTBJWIR>; Mon, 10 Feb 2003 17:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTBJWIR>; Mon, 10 Feb 2003 17:08:17 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54031 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265351AbTBJWIP>; Mon, 10 Feb 2003 17:08:15 -0500
Date: Mon, 10 Feb 2003 17:14:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Crispin Cowan <crispin@wirex.com>
cc: linux-security-module@wirex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
In-Reply-To: <3E471F21.4010803@wirex.com>
Message-ID: <Pine.LNX.3.96.1030210170713.29699C-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-md5; PROTOCOL="application/pgp-signature"; BOUNDARY=------------enigAFD7B6430F191C642C988C1A
Content-ID: <Pine.LNX.3.96.1030210170713.29699D@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------enigAFD7B6430F191C642C988C1A
Content-Type: TEXT/PLAIN; CHARSET=us-ascii; FORMAT=flowed
Content-ID: <Pine.LNX.3.96.1030210170713.29699E@gatekeeper.tmr.com>

On Sun, 9 Feb 2003, Crispin Cowan wrote:

> And I actually like that plan. But I still believe it to be too radical 
> for 2.6. It has many nice properties, but is much more invasive to the 
> kernel. I think it is a very interesting idea for 2.7, and should be 
> floated past the maintainers who will be impacted to see if it has a 
> hope in hell.

Too radical? After the modules rewrite how could anything short of a
rewrite in another language be too radical. At least a unified set of
security hooks would be a feature which would be immediately useful and
easy to understand. The benefits of the module changes are not as obvious.

With MS pushing their own security initiative, which seems to be building
computers which only run their os, this would have been a really good
feature from a mindshare perspective. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--------------enigAFD7B6430F191C642C988C1A
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030210170713.29699F@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Rx8o5ZkfjX2CNDARAaf4AJ96UU5EQ1qTi0fu9OUt0LU77y8rYwCfRNE7
vzwilVzhD8It1Y9IkMieYgs=
=D4oT
-----END PGP SIGNATURE-----

--------------enigAFD7B6430F191C642C988C1A--
