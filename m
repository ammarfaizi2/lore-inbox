Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUBRO2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUBRO1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:27:35 -0500
Received: from cable212a115.usuarios.retecal.es ([212.183.212.115]:21377 "EHLO
	debian") by vger.kernel.org with ESMTP id S267428AbUBRO0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:26:39 -0500
Subject: Re: 2.6.3-mm1
From: Ramon Rey Vicente <rrey@ranty.pantax.net>
Reply-To: ramon.rey@hispalinux.es
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040217232130.61667965.akpm@osdl.org>
References: <20040217232130.61667965.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s8+rW4r9VwlzcTB13Rmj"
Message-Id: <1077114386.12206.2.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 15:26:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s8+rW4r9VwlzcTB13Rmj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

With ACPI disabled and APM enabled I get this build error.

arch/i386/kernel/built-in.o(.text+0xbf3a): In function `acpi_apic_setup':
: undefined reference to `smp_found_config'
arch/i386/kernel/built-in.o(.text+0xbf43): In function `acpi_apic_setup':
: undefined reference to `clustered_apic_check'
make: *** [.tmp_vmlinux1] Error 1
--=20
Ram=C3=B3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-s8+rW4r9VwlzcTB13Rmj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAM3YQRGk68b69cdURAn67AJ9kJckq+M9ll5VXE41jWKwT/QhZUwCghICH
88upRqXY828u/lFgvfyhJZo=
=BxP5
-----END PGP SIGNATURE-----

--=-s8+rW4r9VwlzcTB13Rmj--
