Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTLXKdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 05:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTLXKdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 05:33:21 -0500
Received: from komoseva.globalnet.hr ([213.149.32.250]:13582 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S263522AbTLXKdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 05:33:20 -0500
Date: Wed, 24 Dec 2003 10:27:00 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Jean-Luc Fontaine <jfontain@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
Message-ID: <20031224092700.GA1406@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Jean-Luc Fontaine <jfontain@free.fr>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
X-Operating-System: Linux 2.6.0
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2003 at 01:42:22PM +0100, Jean-Luc Fontaine wrote:
> on 2.4:
>   Timing buffer-cache reads:   168 MB in  2.01 seconds =3D  83.58 MB/sec
>   Timing buffered disk reads:   44 MB in  3.12 seconds =3D  14.10 MB/sec
> on 2.6:
>   Timing buffer-cache reads:   172 MB in  2.02 seconds =3D  84.95 MB/sec
>   Timing buffered disk reads:   34 MB in  3.08 seconds =3D  11.04 MB/sec
>=20
> Note the big drop of of 3 MB/sec on disk reads.

Consider yourself lucky :o)

I had a drop from 55Mb/s to around 35, 2.4.22->2.6.0-test&final.
Promise 20265, Seagate Barracuda 7.7200 80Gb, so nice ;)

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0 #3 Thu Dec 18 14:21:52 CET 2003 i686
 10:24:23 up 17:28, 11 users,  load average: 0.50, 0.44, 0.41
A clear conscience is usually the sign of a bad memory.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6Vvkq1AzG0/iPGMRAhfUAKDWdBIP672vFeViCoM+tSH9O9DZ6ACeLYjD
35dlf9mPn33VkSPJTF87Qs4=
=YenO
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
