Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTKCSyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTKCSyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:54:40 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:46483 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263137AbTKCSyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:54:38 -0500
Date: Mon, 3 Nov 2003 20:53:34 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How provoke call stack trace
Message-ID: <20031103185334.GS32115@actcom.co.il>
References: <3FA6A0AF.2070300@softhome.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NYEXl3WhqsXurSTm"
Content-Disposition: inline
In-Reply-To: <3FA6A0AF.2070300@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NYEXl3WhqsXurSTm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2003 at 07:38:39PM +0100, Ihar 'Philips' Filipau wrote:

>    Is there any function which can be used by module to just=20
> investigate some given call path?

Assuming 2.6, call dump_stack(). If you want greater flexibility,
investigate show_trace() and friends.=20

Hope this helps,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--NYEXl3WhqsXurSTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pqQuKRs727/VN8sRAnp6AJ4wLKCwHld5p/Xm7VjH/AuvTCL51ACgufSq
rilcj4DSGiTWuBtiVdwwyUE=
=n+li
-----END PGP SIGNATURE-----

--NYEXl3WhqsXurSTm--
