Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSBGKqK>; Thu, 7 Feb 2002 05:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSBGKqA>; Thu, 7 Feb 2002 05:46:00 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:2322 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S287208AbSBGKpv>; Thu, 7 Feb 2002 05:45:51 -0500
Date: Thu, 7 Feb 2002 11:45:48 +0100
From: Kurt Garloff <garloff@suse.de>
To: Bruce Harada <harada@mbr.sphere.ne.jp>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Misc ICH ID changes/additions
Message-ID: <20020207114548.C25360@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Bruce Harada <harada@mbr.sphere.ne.jp>,
	Jeff Garzik <garzik@havoc.gtf.org>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020131224122.59d1de9e.bruce@ask.ne.jp> <E16WIFn-0002Iy-00@the-village.bc.nu> <20020201022958.7b58493f.harada@mbr.sphere.ne.jp> <20020131141025.E669@havoc.gtf.org> <20020201095457.23a30eb5.harada@mbr.sphere.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20020201095457.23a30eb5.harada@mbr.sphere.ne.jp>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

On Fri, Feb 01, 2002 at 09:54:57AM +0900, Bruce Harada wrote:
> On Thu, 31 Jan 2002 14:10:25 -0500
> Jeff Garzik <garzik@havoc.gtf.org> wrote:
>=20
> > Would it be possible to produce two patches, the first adding new ids,
> > and the second doing the rename you want?
>=20
> Sure, no problem. Here's the ID additions/changes:
>=20
> diff -urN -X dontdiff linux-2.4.18-pre7/drivers/pci/pci.ids linux-2.4.18-=
pre7-bjh/drivers/pci/pci.ids
> --- linux-2.4.18-pre7/drivers/pci/pci.ids	Thu Jan 31 20:29:13 2002
> +++ linux-2.4.18-pre7-bjh/drivers/pci/pci.ids	Fri Feb  1 00:35:02 2002

Actually this part should also go to the pci ID stuff at sourceforge, if
it's not there already:
http://pciids.sourceforge.net/

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8YlrcxmLh6hyYd04RAg7yAJ9hnwL4Y4lffdbQaMxPeu6RXwmdvACghK+k
F1gv3sxoBRenxzyTx3M5bp0=
=Ym1f
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
