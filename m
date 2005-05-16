Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVEPSdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVEPSdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVEPSdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:33:15 -0400
Received: from nysv.org ([213.157.66.145]:28354 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261791AbVEPSbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:31:44 -0400
Date: Mon, 16 May 2005 21:31:05 +0300
To: Con Kolivas <kernel@kolivas.org>
Cc: AndrewMorton <akpm@osdl.org>, Carlos Carvalho <carlos@fisica.ufpr.br>,
       ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [SMP NICE] [PATCH] SCHED: Implement nice support across physical cpus on SMP
Message-ID: <20050516183105.GK1399@nysv.org>
References: <20050509112446.GZ1399@nysv.org> <17023.63512.319555.552924@fisica.ufpr.br> <200505111304.06853.kernel@kolivas.org> <200505162133.13399.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YszDAcSgCu6rDIlP"
Content-Disposition: inline
In-Reply-To: <200505162133.13399.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YszDAcSgCu6rDIlP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2005 at 09:33:09PM +1000, Con Kolivas wrote:
>
>It looks like I missed my window of opportunity and the SMP balancing desi=
gn=20
>has been restructured in latest -mm again so this patch will have to wait=
=20

=2E..incredible...

--=20
mjt


--YszDAcSgCu6rDIlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCiObpIqNMpVm8OhwRAt8nAKCjGmZsxf85IocgOXcEmmwDC8ypMgCZAR2I
VVDTkVe6MdWaG/uzrjz/HFk=
=4pHq
-----END PGP SIGNATURE-----

--YszDAcSgCu6rDIlP--
