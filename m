Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUIFNBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUIFNBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUIFM7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:59:20 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:49880 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S267963AbUIFM5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:57:44 -0400
Date: Mon, 6 Sep 2004 14:57:32 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1544176737.20040906145732@tnonline.net>
To: Clemens Schwaighofer <cs@tequila.co.jp>
CC: Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <413C5DDD.6070005@tequila.co.jp>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus>
 <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus>
 <413C5DDD.6070005@tequila.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1

> Frank van Maarseveen wrote:

|>>
|>>We have the mount command for that.  :^)
> |
> |
> | mount is nice for root, clumsy for user. And a rather complicated
> | way of accessing data the kernel has knowledge about in the first
> | place. For filesystem images, cd'ing into the file is the most
> | obvious concept for file-as-a-dir IMHO.

> thats why we have automount.

  Which still needs to be setup in fstab, right?

> lg, clemens
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

> iD8DBQFBPF3djBz/yQjBxz8RAmVhAKCODKNKOV9V0I59SUfQ1pp+qk88xwCg6+4p
> Q+JcbO+W0+6cUfSEf3z/Iwk=
> =IwZQ
> -----END PGP SIGNATURE-----

