Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTITU3d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTITU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:29:33 -0400
Received: from dhcp065-024-038-074.columbus.rr.com ([65.24.38.74]:34988 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261963AbTITU3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:29:31 -0400
Date: Sat, 20 Sep 2003 16:31:30 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] input: Restore synaptics pad mode on module unload
Message-ID: <20030920203130.GB16742@rivenstone.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
References: <10639672004187@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <10639672004187@twilight.ucw.cz>
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


    Vojtech, how do you feel about the psmouse_imps2 patch[1] that's
been in -mm since -test4-mm5?  Several people have told me it's been
useful for them, to either make their Belkin KVM switches work with
Logitech mice or to disable the Synaptics touchpad driver at runtime
and still be able to use scroll mice.

[1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-te=
st4/2.6.0-test4-mm5/broken-out/psmouse_ipms2-option.patch

    I could write a patch to selectively enable or disable all the
different mouse drivers if you would prefer something more general. =20

--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bLkiWv4KsgKfSVgRArZEAKCjSGYgE4g3p1rhpJLy15GWgllkBACfSAK/
0e7YWCcZQombqSz0Z9oRApU=
=2pUo
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
