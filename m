Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUBDTcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUBDTcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:32:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:18643 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263898AbUBDTcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:32:12 -0500
Date: Wed, 4 Feb 2004 20:31:54 +0100
From: "Juergen E. Fischer" <fischer@linux-buechse.de>
To: david.ronis@mcgill.ca
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problem with module-init-tools-3.0-pre3
Message-ID: <20040204193154.GA29661@linux-buechse.de>
Mail-Followup-To: david.ronis@mcgill.ca, linux-kernel@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <16417.14736.420280.796948@ronispc.chem.mcgill.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:8b0c050ff9179508392b54e1b921775e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, Feb 04, 2004 at 13:27:28 -0500, David Ronis wrote:
> I just built 2.6.2 and tried the scsi driver install/remove problem I
> wrote about earlier (if, I manually remove the sg and aha152x modules
> with modprobe, I get an oops the next time they are used).  The
> problem is still present.

With or without the patch?  It wasn't applied in 2.6.2.


J=FCrgen

--=20
Phase 1: Where do you want to go today?
Phase 2: This is where you want to go today.
Phase 3: You're not going anywhere today.
  -- seen on /.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIUiqc/GhTF5ESHURAqNpAKCZV3WTgw0guyHAetPdpiWQSYT5BQCeMoZ4
ix/4W10ZQvbCHvxj4g2oBxQ=
=J5CV
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
