Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUHVT1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUHVT1a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHVT13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:27:29 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:43427 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268077AbUHVT12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:27:28 -0400
Date: Sun, 22 Aug 2004 21:26:46 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Christer Weinigel <christer@weinigel.se>
Cc: Pascal Schmidt <der.eremit@email.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040822192646.GH19768@thundrix.ch>
References: <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner> <Pine.LNX.4.58.0408221450540.297@neptune.local> <m37jrr40zi.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline
In-Reply-To: <m37jrr40zi.fsf@zoo.weinigel.se>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Sun, Aug 22, 2004 at 06:00:01PM +0200, Christer Weinigel wrote:
>     If you want to be able to run snazzycdwriter(tm) as a normal user,
>     add the following command to your rc.local file:
>=20
>         /sbin/install-scsi-filter /dev/hdc snazzycdwriter.filter

Well, for that it might be  a nice feature to register and delete such
filters  online, using  a  register/remove_scsi_filter interface,  but
well, otoh that might be undesirable security-wise.

			    Tonnerre

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBKPN1/4bL7ovhw40RArctAJsHVWwZoUo6JIEwpcU9IL6lQr88swCgtgpm
qWA/KvoYZi/UDDsZqwK0T1k=
=VPhV
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
