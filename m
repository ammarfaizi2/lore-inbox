Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSHAROb>; Thu, 1 Aug 2002 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSHAROb>; Thu, 1 Aug 2002 13:14:31 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:58274 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317068AbSHAROa>; Thu, 1 Aug 2002 13:14:30 -0400
Date: Thu, 1 Aug 2002 20:13:03 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Karim Yaghmour <karim@opersys.com>
Cc: Fabrizio Morbini <fabrizio.morbini@libero.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tracing each new process...
Message-ID: <20020801171303.GC7912@alhambra.actcom.co.il>
References: <Pine.LNX.4.33L2.0208011340130.957-100000@localhost.localdomain> <3D496A33.2192F164@opersys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <3D496A33.2192F164@opersys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2002 at 01:04:51PM -0400, Karim Yaghmour wrote:
>=20
> Have a look at the Linux Trace Toolkit:
> http://www.opersys.com/LTT/

syscalltrack, http://syscalltrack.sourceforge.net can do it as
well. You'll get the notification in user space out of the box, and in
kernel space with a bit of hacking.=20

> Fabrizio Morbini wrote:
> > Hi, somebody know how signaling the creation of each new process?
> > (watching the proc filesystem or ps output is too slow)
> >=20
> > If this software doesn't exists where (in the kernel source) I must
> > insert hook for tracing the creation of new process?
--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SWwfKRs727/VN8sRAkJ1AJ91VlnDPZukjn7ZxU8CJKdtSCm3cwCggTNe
2ssrbzktbAsmA9yo9sl+N1U=
=JZAG
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
