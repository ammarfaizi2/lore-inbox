Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUIFNUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUIFNUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIFNUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:20:42 -0400
Received: from dev.tequila.jp ([128.121.50.153]:60430 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268033AbUIFNUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:20:03 -0400
Message-ID: <413C6360.1030506@tequila.co.jp>
Date: Mon, 06 Sep 2004 22:17:20 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@xs4all.nl>
CC: Spam <spam@tnonline.net>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <413C5DDD.6070005@tequila.co.jp> <1544176737.20040906145732@tnonline.net> <413C5F2D.6080802@tequila.co.jp> <20040906130113.GA32306@janus>
In-Reply-To: <20040906130113.GA32306@janus>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank van Maarseveen wrote:
| On Mon, Sep 06, 2004 at 09:59:25PM +0900, Clemens Schwaighofer wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Spam wrote:
|>
|>| thats why we have automount.
|>|
|>|
|>|>   Which still needs to be setup in fstab, right?
|>
|>no, in /etc/automount* actually. I have no fstab entry here and still I
|>can mount various samba shares, cdroms, etc ...
|
|
| but can you access images that way?
|

in theory yes, but only predefined ones. But I don't see automount for
this. more for cdroms and other removable medias.

I haven't had the need to mount and iso for quite some time, so I don't
know if I need root access for that, but I think yes like for all mount
things.

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBPGNgjBz/yQjBxz8RAsm7AJsEwa18ymMBWKf1rJ2PAwPOfCMIJgCglaNS
d8OqXmD0jsYezcE8u7BGrkM=
=ctEE
-----END PGP SIGNATURE-----
