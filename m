Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUCCJAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbUCCJAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:00:55 -0500
Received: from mx1.actcom.co.il ([192.114.47.13]:3810 "EHLO smtp1.actcom.co.il")
	by vger.kernel.org with ESMTP id S261477AbUCCJAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:00:51 -0500
Date: Wed, 3 Mar 2004 10:55:01 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Rik Faith <faith@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, okir@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
Message-ID: <20040303085501.GC31052@mulix.org>
References: <16451.25789.72815.763592@neuro.alephnull.com> <20040301194501.A9080@infradead.org> <16451.40189.997259.379123@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <16451.40189.997259.379123@neuro.alephnull.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2004 at 03:28:45PM -0500, Rik Faith wrote:

> > Whether we want syscall auditing in mainline is a completely different
> > question..
>=20
> I believe we need a light-weight, maintainable framework that is
> versatile enough to be used for non-security purposes (e.g., debugging).
> In general, my patch meets these requirements since it provides very
> little that helps specifically with security (failure modes, loginuid,
> and small helper functions).

I'd like to second the sentiment - for syscalltrack, we would love to
have a framework that can be used for debugging system call events.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARZ1kKRs727/VN8sRAnt+AJ9kaERVgUZNsi2yZxM3BLg1HW9JAACfdKeC
x99gi93USUpom03G1zEJvso=
=hODB
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
