Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUIFM4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUIFM4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUIFMz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:55:57 -0400
Received: from dev.tequila.jp ([128.121.50.153]:2822 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S267936AbUIFMzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:55:50 -0400
Message-ID: <413C5DDD.6070005@tequila.co.jp>
Date: Mon, 06 Sep 2004 21:53:49 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@xs4all.nl>
CC: Dave Kleikamp <shaggy@austin.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus>
In-Reply-To: <20040902214806.GA5272@janus>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank van Maarseveen wrote:

|>
|>We have the mount command for that.  :^)
|
|
| mount is nice for root, clumsy for user. And a rather complicated
| way of accessing data the kernel has knowledge about in the first
| place. For filesystem images, cd'ing into the file is the most
| obvious concept for file-as-a-dir IMHO.

thats why we have automount.

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBPF3djBz/yQjBxz8RAmVhAKCODKNKOV9V0I59SUfQ1pp+qk88xwCg6+4p
Q+JcbO+W0+6cUfSEf3z/Iwk=
=IwZQ
-----END PGP SIGNATURE-----
