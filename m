Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVDETAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVDETAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDES6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:58:02 -0400
Received: from vbo91-1-82-238-217-224.fbx.proxad.net ([82.238.217.224]:35209
	"EHLO mirchusko.localnet") by vger.kernel.org with ESMTP
	id S261891AbVDES4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:56:16 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Josselin Mouette <joss@debian.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4252DDE6.5040500@nortel.com>
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>
	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com>
	 <1112723637.4878.14.camel@mirchusko.localnet> <4252DDE6.5040500@nortel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a2vsdpsx0AWDhKydMk4E"
Date: Tue, 05 Apr 2005 20:56:09 +0200
Message-Id: <1112727369.4878.25.camel@mirchusko.localnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a2vsdpsx0AWDhKydMk4E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mardi 05 avril 2005 =C3=A0 12:50 -0600, Chris Friesen a =C3=A9crit :
> Josselin Mouette wrote:
>=20
> > The fact is also that mixing them with a GPLed software gives
> > an result you can't redistribute - although it seems many people
> > disagree with that assertion now.
>=20
> This is only true if the result is considered a "derivative work" of the=20
> gpl'd code.
>=20
> The GPL states "In addition, mere aggregation of another work not based=20
> on the Program with the Program (or with a work based on the Program) on=20
> a volume of a storage or distribution medium does not bring the other=20
> work under the scope of this License."
>=20
> Since the main cpu does not actually run the binary firmware, the fact=20
> that it lives in main memory with the code that the cpu *does* run is=20
> irrelevent.  In this case, the Debian stance is that the kernel proper=20
> and the binary firmware are "merely aggregated" in a volume of storage (=20
> ie. system memory).

It merely depends on the definition of "aggregation". I'd say that two
works that are only aggregated can be easily distinguished and
separated. This is not the case for a binary kernel module, from which
you cannot easily extract the firmware and code parts.
--=20
 .''`.           Josselin Mouette        /\./\
: :' :           josselin.mouette@ens-lyon.org
`. `'                        joss@debian.org
  `-  Debian GNU/Linux -- The power of freedom

--=-a2vsdpsx0AWDhKydMk4E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCUt9JrSla4ddfhTMRAnd5AKD0KNlQR2AT75PDYjjAgpo3gCOf9wCfbx1X
iurvf25OcXHY+XyoNW/PXy0=
=E9qC
-----END PGP SIGNATURE-----

--=-a2vsdpsx0AWDhKydMk4E--
