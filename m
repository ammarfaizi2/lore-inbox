Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbUEBI6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUEBI6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUEBI6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:58:07 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:53717 "EHLO
	extern.mail.waldi.eu.org") by vger.kernel.org with ESMTP
	id S262931AbUEBI6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:58:04 -0400
Date: Sun, 2 May 2004 10:58:02 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [s390, 2.6.6-rc3] dasd(eckd): Read device characteristics returned error -5
Message-ID: <20040502085802.GA17027@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2.6.6-rc3 is not able to access any dasd on my s390 guest. It fails with
the following error:

| dasd(eckd): Read device characteristics returned error -5
| dasd_generic couldn't online device 0.0.0882 with discipline ECKD

2.6.5 works fine.

Bastian

--=20
Oblivion together does not frighten me, beloved.
		-- Thalassa (in Anne Mulhall's body), "Return to Tomorrow",
		   stardate 4770.3.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkCUuBoACgkQnw66O/MvCNGGLwCdHXOgKUBW6dYdPE4puLi4KpZJ
xQ0An2QIZ1VoynYqpo9g/O1ST8OM1/u7
=EPtP
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
