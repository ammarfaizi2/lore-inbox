Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWITKAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWITKAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 06:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWITKAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 06:00:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57262 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750813AbWITKAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 06:00:35 -0400
X-Sasl-enc: T2mNXDglNguoOt6JoFGq4NPa6G6u7MPaKTOgmmEbYXSC 1158746434
Message-ID: <45111197.6020801@imap.cc>
Date: Wed, 20 Sep 2006 12:01:59 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc7] printk output delay in syslog wrt dmesg still	unfixed
References: <450BF1CC.2070309@imap.cc> <1158691933.18546.3.camel@localhost>
In-Reply-To: <1158691933.18546.3.camel@localhost>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig624EBE06D61C1BD7EA8E00BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig624EBE06D61C1BD7EA8E00BE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 19.09.2006 20:52, john stultz wrote:
> Unfortunately I don't know what would be the cause.=20
>=20
> You might try git-bisect to find the offending patch.
> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with=
-bisect.txt

Um, ok, I'll try. But I've never used git before, so I'll need some time
reading all the docs, installing git and finding my way around it. I'll
report back as soon as I have a result, but I wouldn't expect it to be
in time for the problem to be fixed in 2.6.18 release.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig624EBE06D61C1BD7EA8E00BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFERGeMdB4Whm86/kRAkCXAJ9vIdf2kkes8OP2texnvnBtU6TOUACfaYJU
1OKlHMwVimVcroi1qCb52y8=
=pcIB
-----END PGP SIGNATURE-----

--------------enig624EBE06D61C1BD7EA8E00BE--
