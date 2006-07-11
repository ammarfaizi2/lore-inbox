Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWGKCLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWGKCLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWGKCLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:11:05 -0400
Received: from pool-72-66-204-177.ronkva.east.verizon.net ([72.66.204.177]:11204
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965076AbWGKCLB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:11:01 -0400
Message-Id: <200607110209.k6B29psN007504@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Cc: Lee Revell <rlrevell@joe-job.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
In-Reply-To: Your message of "Tue, 11 Jul 2006 01:38:39 +0200."
             <44B2E4FF.9000502@pg.gda.pl>
From: Valdis.Kletnieks@vt.edu
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl> <1152571717.19047.36.camel@mindpipe>
            <44B2E4FF.9000502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152583790_4450P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 22:09:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152583790_4450P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2006 01:38:39 +0200, =3D?ISO-8859-2?Q?Adam_Tla=3DB3ka?=3D =
said:
> U=BFytkownik Lee Revell napisa=B3:
>
> > esd and artsd are no longer needed since ALSA began to enable softwar=
e
> > mixing by default in release 1.0.9.
>  >
>=20
> So why they are still exist in so many Linux distributions?

As soon as somebody writes a patch to make the e16 window manager talk AL=
SA
rather than use esd, I'm heaving esd over the side.

Of course, I've been saying that since ALSA 1.0.9 came out.  (And don't
suggest I write it myself - I could if I was motivated enough, but I'm no=
t
motivated at the current time. :)

--==_Exmh_1152583790_4450P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEswhucC3lWbTT17ARAhdwAKD6LORdtti4AHXf2rkazFe9VVvmVwCcCZR4
MKS1rlYYDh5NQaOKL8sZ9o4=
=HPen
-----END PGP SIGNATURE-----

--==_Exmh_1152583790_4450P--
