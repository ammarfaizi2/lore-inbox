Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSGJSsS>; Wed, 10 Jul 2002 14:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSGJSsR>; Wed, 10 Jul 2002 14:48:17 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:12375 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S315503AbSGJSsR>; Wed, 10 Jul 2002 14:48:17 -0400
Date: Wed, 10 Jul 2002 20:49:22 +0200
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Perches, Joe" <joe.perches@spirentcom.com>, thunder@ngforever.de,
       bunk@fs.tum.de, boissiere@adiglobal.com, linux-kernel@vger.kernel.org,
       "'Larry Kessler'" <kessler@us.ibm.com>,
       "'Martin.Bligh@us.ibm.com'" <Martin.Bligh@us.ibm.com>
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020710184922.GN12910@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Perches, Joe" <joe.perches@spirentcom.com>, thunder@ngforever.de,
	bunk@fs.tum.de, boissiere@adiglobal.com,
	linux-kernel@vger.kernel.org, 'Larry Kessler' <kessler@us.ibm.com>,
	"'Martin.Bligh@us.ibm.com'" <Martin.Bligh@us.ibm.com>
References: <629E717C12A8694A88FAA6BEF9FFCD440540BD@brigadoon.spirentcom.com> <E17SMM3-0007Z8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qa0ccP92Gc0Ko3P8"
Content-Disposition: inline
In-Reply-To: <E17SMM3-0007Z8-00@the-village.bc.nu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qa0ccP92Gc0Ko3P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Wed, Jul 10, 2002 at 07:38:23PM +0100, Alan Cox wrote:
> > While I understand the possible value, are printk translations
> > really important enough to justify?
>=20
> Is it worth chsnging the kernel just for translations - probably not. If
> it comes out as a convenient side effect - yes.

I'd still say no. Kernel messages are meant not meant for end users but for
kernel developers. The latter all speak english, but chances are that most
of them won't understand japanese kernel messages. So they would need to
be translated back before posted here.

If you want translated kernel messages, use message IDs, that can be parsed
and translated in userspace, if somebody really needs it.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--Qa0ccP92Gc0Ko3P8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9LIGyxmLh6hyYd04RAvg9AJ94egg0fFlsvVilFAnogJmS/9IhkQCfYVIs
CfAz06L6GA+KMLiLQ1Bc3k8=
=2eQO
-----END PGP SIGNATURE-----

--Qa0ccP92Gc0Ko3P8--
