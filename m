Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWG3WCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWG3WCT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWG3WCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:02:19 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53978 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932469AbWG3WCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:02:18 -0400
X-Sasl-enc: 6ZDPef5Aqe1EEU/UIukh0pZ9kRDWKd9kLtB75T2hpXL+ 1154296940
Message-ID: <44CD2C76.2030700@imap.cc>
Date: Mon, 31 Jul 2006 00:02:30 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
References: <06Jul25.011533edt.35900@gpu.utcc.utoronto.ca>
In-Reply-To: <06Jul25.011533edt.35900@gpu.utcc.utoronto.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE99FECA8BB1CD7FEB57C108C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE99FECA8BB1CD7FEB57C108C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.07.2006 07:15, Chris Siebenmann wrote:
> You write:
> | [...] Therefore an attitude which says "go on developing that
> | code out-of-tree, it's not ready for inclusion yet" is in direct
> | contradiction with the foundations of the no-stable-API policy.
>=20
>  I don't think that there's a contradiction, because I believe that wha=
t
> the kernel developers are saying in general can be rewritten as:
>=20
> 	- we don't care about things that are deliberately kept
> 	  out of the kernel
> *and*	- we also don't care about code that does not meet quality
> 	  or relevance standards

Actually, that *isn't* what I read regularly in lkml. Most statements of
rejection by kernel developers do *not* read "we don't care about that,
go away", but "this needs work here and there before we will accept it",
which in a way is the opposite of "we don't care".

But I am growing tired of this discussion. I tried to help, and instead
drew fire myself. My own fault of course. I misjudged the situation and
the emotional content of the ongoing dispute. I will now keep my tongue.

Regards
Tilman

PS: I was forced to give this answer publicly because your given E-mail
address wouldn't accept my private mail answer. My apologies if this is
not what you wanted.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigE99FECA8BB1CD7FEB57C108C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzSx/MdB4Whm86/kRAp7zAJ0crnTZ+0+i1UTYf9UnFktG/WYLIACdHmDG
4F6IjXs1F7rLa/vWop9l6Jo=
=vPi4
-----END PGP SIGNATURE-----

--------------enigE99FECA8BB1CD7FEB57C108C--
