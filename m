Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132463AbRAJNRf>; Wed, 10 Jan 2001 08:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135192AbRAJNRZ>; Wed, 10 Jan 2001 08:17:25 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:36871 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S132463AbRAJNRL>; Wed, 10 Jan 2001 08:17:11 -0500
Date: Wed, 10 Jan 2001 14:16:17 +0100
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010110141617.H9756@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1> <20010109142156.L25659@mea-ext.zmailer.org> <20010109082749.A2971@scutter.internal.splhi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109082749.A2971@scutter.internal.splhi.com>; from timw@splhi.com on Tue, Jan 09, 2001 at 08:27:49AM -0800
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2001 at 08:27:49AM -0800, Tim Wright wrote:
> On Tue, Jan 09, 2001 at 02:21:56PM +0200, Matti Aarnio wrote:
> [...]
> >   On the other hand, Alpha systems and SPARC systems have IOMMU hardwar=
e,
> >   and we do support that (to some extent), but 32-bit intel world doesn=
't
> >   have similar things.
>=20
> you are correct in saying that ia32 systems don't have IOMMU hardware,

Well, there is: AGPGART does something like this.=20
I don't know, if it support more than 32bits address space, though.

> but it's unfortunate that we don't support 64-bit PCI bus master cards,

Indeed.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XGCgxmLh6hyYd04RAjSaAJ99h5aRxZ+vAvJL9k16iHFRpOIjkQCgs0+F
Dlv9ArSbIf2CcVCRDXRxrlg=
=O/tE
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
