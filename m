Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTEPTAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 15:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264611AbTEPTAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 15:00:53 -0400
Received: from www.hostsharing.net ([212.42.230.151]:16040 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S264612AbTEPTAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 15:00:50 -0400
Date: Fri, 16 May 2003 21:15:11 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: radeonfb and acpi
Message-ID: <20030516191511.GB669@gandalf.home.lxtec.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030515195025.GB696@gandalf.home.lxtec.de> <20030516083620.GA1687@deimos.one.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <20030516083620.GA1687@deimos.one.pl>
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2003 the mental interface of=20
Damian Ko?kowski told:

> On Thu, May 15, 2003 at 09:50:25PM +0200, Elimar Riesebieter wrote:
> > BTW: Which kernel-params do I need to start radeonfb with
> > video:radeonfb=3D1280x1024-16@75 ? The FB even starts with=20
> > colour frame buffer device 80x30.
>=20
> ./home/deimos. # cat /etc/lilo.conf | grep radeon
> append=3D"video=3Dradeon:1024x768-32@100 hdb=3Dide-scsi"
> ./home/deimos. #

This is IMHO fo r ppc's. I am running an i86-32.

I do /usr/sbin/fbset -a -fb /dev/fb0 1280x1024-75. Thats what I
want. That doesn't depend on whether  I am booting radeon or
radeonfb in 2.4.20/2.4.21-rc1.

Ciao and thx

Elimar


--=20
  Learned men are the cisterns of knowledge,=20
  not the fountainheads ;-)

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+xTi/3Ig8bsVPf7ARAv3aAKCjfNGbLXmxX9UjWxVZhZTTBeqZQgCeNvXT
b5I8hNPwJLPrdy9lBM8ehnI=
=t2Aj
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
