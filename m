Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUFNN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUFNN6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUFNN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 09:58:49 -0400
Received: from trantor.org.uk ([213.146.130.142]:13973 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263028AbUFNN6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 09:58:47 -0400
Subject: Local DoS attack on i386 (was: new kernel bug)
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Manuel Arostegui Ramirez <manuel@todo-linux.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406121159.28406.manuel@todo-linux.com>
References: <200406121159.28406.manuel@todo-linux.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-28ZMQTDz0GWNFzAGSDoC"
Date: Mon, 14 Jun 2004 14:58:37 +0100
Message-Id: <1087221517.3375.3.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-28ZMQTDz0GWNFzAGSDoC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-12 at 11:59 +0200, Manuel Arostegui Ramirez wrote:
> Somebody know a patch to solved this new bug?
> http://reviewed.homelinux.org/news/2004-06-11_kernel_crash/index.html.en
> Affected versions:
>     * Linux 2.6.x
>           o Linux 2.6.7-rc2
>           o Linux 2.6.6 (all versions)
>           o Linux 2.6.6 SMP (verified by riven)
>           o Linux 2.6.5-gentoo (verified by RatiX)
>           o Linux 2.6.5-mm6 - (verified by Mariux)=20
>     * Linux 2.4.2x
>           o Linux 2.4.26 vanilla
>           o Linux 2.4.26-rc1 vanilla
>           o Linux 2.4.26-gentoo-r1
>           o Linux 2.4.22=20

Seems to be a scheduler race or something?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-28ZMQTDz0GWNFzAGSDoC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAza8NkbV2aYZGvn0RAgnfAJ0R5rTiH3c+saaUJRHnaXRWvf4vkwCfVCS0
qIXMq8kErZstkveJ1NjhN/I=
=eCX0
-----END PGP SIGNATURE-----

--=-28ZMQTDz0GWNFzAGSDoC--

