Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUDPHN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 03:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUDPHN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 03:13:59 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:56080 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S262545AbUDPHN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 03:13:56 -0400
In-Reply-To: <1082093346.7141.159.camel@lade.trondhjem.org>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11-713196695"
Message-Id: <91344B9E-8F75-11D8-8B4A-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: shannon@widomaker.com, Phil Oester <kernel@linuxace.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Paul Wagland <paul@wagland.net>
Subject: Re: NFS and kernel 2.6.x
Date: Fri, 16 Apr 2004 09:13:31 +0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-11-713196695
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed


On Apr 16, 2004, at 7:29, Trond Myklebust wrote:

> P=E5 to , 15/04/2004 klokka 21:59, skreiv Phil Oester:
>
>> If simply upgrading from 2.4.x to 2.6.x is going to make UDP mounts=20=

>> unusable,
>> perhaps this should be documented -- or the option should be=20
>> deprecated.
>
> As for blanket statements like the above: I have seen no evidence yet
> that they are any more warranted in 2.6.x than they were in 2.4.x. At
> least not as long as I continue to see wire speed performance on reads
> and writes on UDP on all my own test setups.

Just as an aside, I can confirm this as well... we use UDP mounts, and=20=

get a pretty constant 10MB/s (assuming people aren't running bloody=20
xscreensavers!*!)

Cheers,
Paul

--Apple-Mail-11-713196695
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAf4eitch0EvEFvxURAsJgAJ4rDmRZVeaIavb2f4p4zrxzsugJjwCgqJvg
hpUcOWigVtgimOL++eId2Iw=
=MI67
-----END PGP SIGNATURE-----

--Apple-Mail-11-713196695--

