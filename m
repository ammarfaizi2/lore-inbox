Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFKNyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTFKNyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:54:07 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.251]:18145 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id S262123AbTFKNyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:54:01 -0400
Date: Wed, 11 Jun 2003 16:07:26 +0200
From: Rene Engelhard <rene@rene-engelhard.de>
To: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Re: RealTek NIC on alpha?
Message-ID: <20030611140726.GA835@rene-engelhard.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	debian-alpha@lists.debian.org
References: <20030611091910.GD801@rene-engelhard.de> <wrpznkp9d69.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <wrpznkp9d69.fsf@hina.wild-wind.fr.eu.org>
X-Operating-System: Debian GNU/Linux
X-GnuPG-Key: $ finger rene@db.debian.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marc,

Marc Zyngier wrote:
> >>>>> "Rene" =3D=3D Rene Engelhard <rene@rene-engelhard.de> writes:
>=20
> Rene> 8139too Fast Ethernet driver 0.9.2
> Rene> and does not do anything after that.
>=20
> Make sure CONFIG_8139TOO_PIO is set. I had similar problem on one of
> my Multias...

Thanks. That was it..

Regards,

Ren=E9
--=20
 .''`.  Ren=E9 Engelhard -- Debian GNU/Linux Developer
 : :' : http://www.debian.org | http://people.debian.org/~rene/
 `. `'  rene@debian.org | GnuPG-Key ID: 248AEB73
    `-   Fingerprint: 41FA F208 28D4 7CA5 19BB  7AD9 F859 90B0 248A EB73

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5zee+FmQsCSK63MRAghfAJ9cWB/KtPkVNYA4LSJ6rmpY7gVAIQCdGGJv
Knwfl8pmHRIwi/i29Yhw0kY=
=Z5Bl
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
