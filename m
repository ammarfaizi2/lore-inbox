Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTLBAwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTLBAwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 19:52:13 -0500
Received: from smtp3.cwidc.net ([154.33.63.113]:43507 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S264108AbTLBAwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 19:52:11 -0500
Message-ID: <3FCBE20B.1010607@tequila.co.jp>
Date: Tue, 02 Dec 2003 09:51:23 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
References: <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcelo Tosatti wrote:

| Nathan,
|
| I think XFS should be a 2.6 only feature.
|
| 2.6 is already stable enough for people to use it.

It is not. It is still in development, and even if a 2.6.0 is
released I just think back to 2.4.0, just because it is called stable
doesn't make it stable.
I am sure it will need at least half a year for the major distros
(RedHat, Novell/SuSe, Mandrake) to pick it up. Perhaps some others more
earlier (Gentoo who knows), some never (Debian), but still, in the mean
time it is always a bit tricky with kernel updats here. Either I patch
it with the SGI and might have troubles with other patches, or I take
the -ac (which didn't work last time because of some driver problems
with the HP/Compaq Raid) or I take the -ck which is a Desktop patchset
and not a server patchset ...
Well in just my opinion XFS should go into 2.4 (and not only because ALL
other FS are in there already). 2.4 will be the main kernel for quite
some more time and always come up with the argument "but 2.6 is so
ready" doesn't help ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/y+IKjBz/yQjBxz8RAlmAAJ44ixaLQ0UWX+y3pfM3AGJplJ/VdwCfSHP8
ghIZWUtwQhg+ZHU/iN4obzI=
=KfM2
-----END PGP SIGNATURE-----

