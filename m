Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLDPrR>; Mon, 4 Dec 2000 10:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLDPrH>; Mon, 4 Dec 2000 10:47:07 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:3851 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129340AbQLDPqz>; Mon, 4 Dec 2000 10:46:55 -0500
Date: Mon, 4 Dec 2000 16:14:21 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andries Brouwer <aeb@veritas.com>
Cc: K Ratheesh <rathee@lantana.tenet.res.in>, linux-kernel@vger.kernel.org
Subject: Re: Linux for local languages - patch
Message-ID: <20001204161421.M6281@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andries Brouwer <aeb@veritas.com>,
	K Ratheesh <rathee@lantana.tenet.res.in>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012040923020.29288-100000@lantana.iitm.ernet.in> <20001204130553.A19985@veritas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="q8dntDJTu318bll0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001204130553.A19985@veritas.com>; from aeb@veritas.com on Mon, Dec 04, 2000 at 01:05:53PM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--q8dntDJTu318bll0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 04, 2000 at 01:05:53PM +0100, Andries Brouwer wrote:
> On Mon, Dec 04, 2000 at 09:32:58AM +0530, K Ratheesh wrote:
> > Even though the patch has been developed keeping Indian languages in mi=
nd,
> > I feel it will be applicable to many other languages (for eg. Chinese)
> > which require wider fonts on console or user defined parsing at I/O lev=
el.
>=20
> Yes, maybe. Or maybe something like this is better done in user space.
>=20
> > Those who want to try out this patch can send mail to me in the address
> > rathee@lantana.iitm.ernet.in or to indlinux-iitm@lantana.iitm.ernet.in=
=20
>=20
> Wouldnt mind seeing your patch.

Andries, I sent you a patch a couple of months ago which does enable the
support of wide characters and another font (besides the sun12x22) making
use of it. I hope it's in your codebase by now, so it does not get lost
when the advanced things of K Ratheesh get merged.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--q8dntDJTu318bll0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6K7TNxmLh6hyYd04RAoGkAJ0ePikFzlCIYL1TTMQcGgy3j6tGlQCfXNOW
mgLYVygUZ0s2RzZzIPoe4Qs=
=DNHX
-----END PGP SIGNATURE-----

--q8dntDJTu318bll0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
