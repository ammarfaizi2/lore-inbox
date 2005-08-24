Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVHXNIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVHXNIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 09:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVHXNIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 09:08:34 -0400
Received: from defiant.lowpingbastards.de ([213.178.77.226]:23430 "EHLO
	mail.lowpingbastards.de") by vger.kernel.org with ESMTP
	id S1750945AbVHXNId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 09:08:33 -0400
Date: Wed, 24 Aug 2005 15:08:23 +0200
From: Frederik Schueler <fs@lowpingbastards.de>
To: Christoph Hellwig <hch@infradead.org>,
       Frederik Schueler <fs@lowpingbastards.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: new qla2xxx driver breaks SAN setup with 2 controllers
Message-ID: <20050824130823.GF13391@mail.lowpingbastards.de>
References: <20050823112535.GB13391@mail.lowpingbastards.de> <20050823200040.GA8310@us.ibm.com> <20050824095520.GD13391@mail.lowpingbastards.de> <20050824100112.GA27216@infradead.org> <20050824124803.GE13391@mail.lowpingbastards.de> <20050824125022.GA29817@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20050824125022.GA29817@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

no change.

On Wed, Aug 24, 2005 at 01:50:22PM +0100, Christoph Hellwig wrote:
> > > Actually this sounds like a bug in your storage system.  It's probably
> > > reporting to be only SCSI2 complicant, which doesn't make sense for
> > > FC storage.  Please try the patch below:
> >=20
> > [...]
> >=20
> > Unfortunately this does not fix this issue, besides the SAN being=20
> > reported as a scsi3 device now.
>=20
> Cane you add BLIST_SPARSELUN and BLIST_LARGELUN to the flags aswell?

--=20
ENOSIG

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDHFH6n7So0GVSSARAnIcAKCPo5PhIeOZQv6jkAS7TQe0P95M/wCgj8n9
lzOwzPLZ+HKkkD8OkEXU0s0=
=0FAC
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
