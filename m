Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbRFYLpJ>; Mon, 25 Jun 2001 07:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264288AbRFYLo7>; Mon, 25 Jun 2001 07:44:59 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:8710 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264272AbRFYLoq>; Mon, 25 Jun 2001 07:44:46 -0400
Date: Mon, 25 Jun 2001 06:43:36 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: rio500-devel <rio500-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] rio500 devfs support
Message-ID: <20010625064336.A9650@glitch.snoozer.net>
Mail-Followup-To: rio500-devel <rio500-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net> <20010624173711.A1764@glitch.snoozer.net> <200106250616.f5P6Gp710044@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <200106250616.f5P6Gp710044@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sun Jun 24 16:53:30 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, back to the original version then.  Thanx!

On Mon, Jun 25, 2001 at 12:16:51AM -0600, Richard Gooch wrote:
> No, it's a bad idea to test the error from devfs_register() unless you
> *really* have a good reason. Most people who think they have a good
> reason actually don't, they're just confused :-)
>=20
> The reason you don't want to test the return value is that way the
> driver works fine with CONFIG_DEVFS=3Dn. Otherwise, you have a driver
> that doesn't work with devfs, or you have to put ugly #ifdef's in the
> code.
>=20
> 				Regards,
>=20
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7NyPogrEMyr8Cx2YRAnVZAJ0SsUzcUuLWGWwPen64DAGIjWkqnwCePOiZ
D+JOamyko4YdGXLOT2XWGok=
=SLtr
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
