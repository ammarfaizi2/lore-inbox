Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268193AbTALBqQ>; Sat, 11 Jan 2003 20:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268196AbTALBqQ>; Sat, 11 Jan 2003 20:46:16 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:44366 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268193AbTALBqP>; Sat, 11 Jan 2003 20:46:15 -0500
Date: Sun, 12 Jan 2003 02:54:56 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: "Harm v.d. Heijden" <H.v.d.Heijden@phys.tue.nl>
Subject: Re: [PATCH] sl82c105 driver update
Message-ID: <20030112015456.GI9153@nbkurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	"Harm v.d. Heijden" <H.v.d.Heijden@phys.tue.nl>
References: <1042302798.525.66.camel@zion.wanadoo.fr> <20030111223231.B21505@flint.arm.linux.org.uk> <1042325055.525.153.camel@zion.wanadoo.fr> <20030111234819.A17524@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
In-Reply-To: <20030111234819.A17524@ucw.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vojtech,

On Sat, Jan 11, 2003 at 11:48:19PM +0100, Vojtech Pavlik wrote:
> Correct, and it seems that if you have automatic DMA disabled in the
> kernel and then use hdparm -d1, this leads to a lot of trouble.

Ack, that's the problem I reported to you the other day, if I'm not mistake=
n.
-d1 -Xwhatever worked, just -d1 not.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers                        SuSE Labs
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IMrwxmLh6hyYd04RAhLFAKC2jrp+pLeaqBPAD4+YahfVceQHUwCgq5jH
rBt6fr+npfxorh/DRB2+Dco=
=eGHY
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
