Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUAEHwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUAEHwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:52:49 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:24749 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265903AbUAEHwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:52:47 -0500
Date: Mon, 05 Jan 2004 20:45:26 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: udev and devfs - The final word
In-reply-to: <m31xqedelx.fsf@lugabout.jhcloos.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Reply-to: ncunningham@clear.net.nz
Message-id: <1073288725.2385.70.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-3RaJWqJM2YbZR7kpCNMJ";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040103040013.A3100@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
 <20040103141029.B3393@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
 <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
 <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
 <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
 <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
 <m31xqedelx.fsf@lugabout.jhcloos.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3RaJWqJM2YbZR7kpCNMJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Mon, 2004-01-05 at 20:44, James H. Cloos Jr. wrote:
> >>>>> "Linus" =3D=3D Linus Torvalds <torvalds@osdl.org> writes:
>=20
> Linus> Why? Becuase that _program_ sure as hell isn't
> Linus> running across a reboot.
>=20
> Is that strictly true?  With (software) suspend to disk,
> will the old device enumeration data be recovered from
> the suspend partition?

Yes. You end up running the original kernel.

Regards,

Nigel

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-3RaJWqJM2YbZR7kpCNMJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+RYVVfpQGcyBBWkRAlBHAJ0e4hwg1ELvpRT8gDM8z1svmdDd5ACfdI8I
0daYfj9yT7JmddVQKo7+0Yw=
=RB1V
-----END PGP SIGNATURE-----

--=-3RaJWqJM2YbZR7kpCNMJ--

