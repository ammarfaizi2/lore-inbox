Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWBQBcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWBQBcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWBQBcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:32:19 -0500
Received: from CPE-141-168-16-16.nsw.bigpond.net.au ([141.168.16.16]:55976
	"EHLO sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S932094AbWBQBcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:32:18 -0500
Date: Fri, 17 Feb 2006 12:32:17 +1100
To: linux-kernel@vger.kernel.org
Subject: Re: poweroff on i386
Message-ID: <20060217013217.GP26235@samad.com.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060217012739.GO26235@samad.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BnCwdHgQ2ZomtW9r"
Content-Disposition: inline
In-Reply-To: <20060217012739.GO26235@samad.com.au>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BnCwdHgQ2ZomtW9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2006 at 12:27:39PM +1100, Alexander Samad wrote:
> Hi
>=20
> I am interested in how the linux kernel powers off i386 machine.  I
> basically followed the path from /sbin/poweroff to halt.c to the kernel
> system command reboot and that into apm apm_power_off  I can't find
> where the non apm machine get powered off

Found it in the drivers/acpi - i was initially only looking in the arch
section

>=20
> Alex



--BnCwdHgQ2ZomtW9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9SehkZz88chpJ2MRAgoLAJ99h/0VAT7dU0STFKTaG3NyVVxQ4wCfRmB7
6Oh3eMyeEZeXY42Hy5FHHW8=
=fTQ3
-----END PGP SIGNATURE-----

--BnCwdHgQ2ZomtW9r--
