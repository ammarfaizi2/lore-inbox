Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264464AbTCXWSw>; Mon, 24 Mar 2003 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264463AbTCXWSw>; Mon, 24 Mar 2003 17:18:52 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:18421 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S264472AbTCXWSo>; Mon, 24 Mar 2003 17:18:44 -0500
Subject: Re: SNARE and Ptrace?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324222027.GD683@rdlg.net>
References: <20030324222027.GD683@rdlg.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ntGoMMyOuPBoXl87HRer"
Organization: Red Hat, Inc.
Message-Id: <1048544987.1636.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Mar 2003 23:29:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ntGoMMyOuPBoXl87HRer
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-24 at 23:20, Robert L. Harris wrote:
> Has anyone tested to see if "Snare" from intersectalliance.com can
> detect someone executing a ptrace attack?  An old company I used to work
> for has a number of production kernels out and can't just upgrade them
> all over night so they need a good detection method and short-term fix
> if possible.  In the past we had evaluated Snare which I pointed him to
> but we're not sure if/how it might detect such an attack.

I audited snare several months ago, and back then it was trivial to even
get a basic rm /etc/passwd done unaudited..... the design back then was
just not tight. I've heard the SNARE guys have been working hard to
improve that but I've not had time to look at the new code

--=-ntGoMMyOuPBoXl87HRer
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+f4bbxULwo51rQBIRAjeJAJsHFwaeonvRmQcR4zBRHY4rCRlyoACgmgzc
BMdkxhTWKG6jIzWGT4UcAMc=
=aGCO
-----END PGP SIGNATURE-----

--=-ntGoMMyOuPBoXl87HRer--
