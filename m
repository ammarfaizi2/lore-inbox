Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317913AbSFNNy0>; Fri, 14 Jun 2002 09:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317914AbSFNNyZ>; Fri, 14 Jun 2002 09:54:25 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:32776 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S317913AbSFNNyY>;
	Fri, 14 Jun 2002 09:54:24 -0400
Date: Fri, 14 Jun 2002 17:52:29 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Dave Jones <davej@suse.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020614135229.GA313@pazke.ipt>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain> <20020614024547.H16772@suse.de> <20020614134152.GA1293@pazke.ipt> <20020614154945.M16772@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.5.21 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2002 at 03:49:45PM +0200, Dave Jones wrote:
> On Fri, Jun 14, 2002 at 05:41:52PM +0400, Andrey Panin wrote:
>=20
>  > We also have apm.c, bootflag.c and acpi.c which are definetely PC spec=
ific.
>=20
> apm may be present on the others (need visws/voyager folks to comment on
> that I guess), but bootflag and acpi I'd suspect not.

IMHO Voyagers are too old and big machines to get (working) APM,
and visws have no BIOS or limited BIOS emulation.
=20
>  > "Latest" (2.4.17) visws patch which i'm planning to convert for 2.5, u=
ses
>  > function MP_processor_info() from generic mpparse.c. May be it makes s=
ence
>  > to move to some generic file ?
>=20
> Is that the one from the visws sourceforge project ?

Yes it is.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9CfUdBm4rlNOo3YgRAtxGAJ4lKzzzoMIhDjqPilmQshfbNEtdugCfe0UL
I1pD7gSqJG0HSkcIDj+GeSs=
=jefK
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
