Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUDOLhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 07:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUDOLhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 07:37:53 -0400
Received: from mh57.com ([217.160.185.21]:58821 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S262381AbUDOLhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 07:37:51 -0400
Date: Thu, 15 Apr 2004 13:37:41 +0200
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm2 (swsusp not working and acpi problem) (fwd)
Message-ID: <20040415113741.GD5105@mh57.de>
References: <20040410134754.GD468@openzaurus.ucw.cz> <20040415112652.GB28414@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20040415112652.GB28414@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.0 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2004 at 01:26:52PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > I tried updating from 2.6.4-rc1-mm2 to 2.6.5-mm2, and I found two
> > problems:
> >=20
> > First, swsusp stopped working, I get a NULL pointer in
> > _poke_blanked_console' after all the other things seem to be fine.
>=20
> Its not in poke blanked console, its is in memorymanagment. Try latest -a=
a.

I had tried -mm4 later, there it worked again. I'm sorry I forgot to
mention this here.

I'll try the latest -mm on the weekend.

LLAP, Martin

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfnQFmGb6Npij0ewRAi79AJ43G6qW5+/bxFXJ92t8PNBKX2Z+aQCghE3L
COe1X2r1hUgGiyth30ZPfJs=
=91L/
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
