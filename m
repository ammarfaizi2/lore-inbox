Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLCSep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLCSep (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVLCSep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:34:45 -0500
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:32877 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932125AbVLCSeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:34:44 -0500
Message-ID: <4391E52D.6020702@unsolicited.net>
Date: Sat, 03 Dec 2005 18:34:21 +0000
From: David Ranson <david@unsolicited.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
In-Reply-To: <20051203175355.GL31395@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DE812279BD5576EC2AA38EF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DE812279BD5576EC2AA38EF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:

>- support for ipfwadm and ipchains was removed during 2.6
>
>
Surely this one had loads of notice though? I was using iptables with
2.4 kernels.

>- devfs support was removed during 2.6
>
>
Did this affect many 'real' users?

>- removal of kernel support for pcmcia-cs is pending
>- ip{,6}_queue removal is pending
>- removal of the RAW driver is pending
>
>
I don't use any of these. I guess pcmcia-cs may be disruptive for laptop
users.

So far I don't see evidence to suggest huge repeated userspace breakages
between Kernel versions that were implied earlier in this thread.
Whatever, we aren't going to see any more stable branches without
volunteers to do the spadework. As has been pointed out, this won't
always be an easy task.

David

--------------enig1DE812279BD5576EC2AA38EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFDkeUyDYHcaCYtZo4RAu8LAJ4+u4wnJ+nu/+AeKgUlBgrjaNNgNwCg3EoJ
Ix0OGG6cpdP2Oc/ZyxGJKEQ=
=toht
-----END PGP SIGNATURE-----

--------------enig1DE812279BD5576EC2AA38EF--
