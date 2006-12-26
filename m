Return-Path: <linux-kernel-owner+w=401wt.eu-S1754608AbWLZBa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbWLZBa5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 20:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbWLZBa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 20:30:57 -0500
Received: from iucha.net ([209.98.146.184]:40571 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbWLZBa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 20:30:56 -0500
Date: Mon, 25 Dec 2006 19:30:55 -0600
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
Message-ID: <20061226013055.GB22307@iucha.net>
References: <20061225224047.GB6087@iucha.net> <20061225225616.GA22307@iucha.net> <1167088018.16449.16.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <1167088018.16449.16.camel@lade.trondhjem.org>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2006 at 12:06:58AM +0100, Trond Myklebust wrote:
> On Mon, 2006-12-25 at 16:56 -0600, Florin Iucha wrote:
> > BTW, I am using NFSv4 exported async from the server and mounted
> > without any extra options on the client.
>=20
> Doesn't look like it has much to do with NFS. The Oopses appear mainly
> to be occurring when assorted ext3 code calls submit_bio(). Was that the
> entire Oops text?

Yes, that was the entire oops text.  NFS appeared on the stack trace
and I thought I might be useful to know more about the code paths.

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFkHtPND0rFCN2b1sRAruFAJ9R0axiDHNqKzCjOULnDoIGqNg3PwCfcxUp
fg6M6pTDoIfaD+VSMgdqsZk=
=p8ng
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
