Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbREQW56>; Thu, 17 May 2001 18:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbREQW5s>; Thu, 17 May 2001 18:57:48 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:25559 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262208AbREQW5j>; Thu, 17 May 2001 18:57:39 -0400
Date: Thu, 17 May 2001 23:57:37 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.xx ? messages related to parport printer ?
Message-ID: <20010517235737.I11263@redhat.com>
In-Reply-To: <3AFAAFE1.DEA0DA6D@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFAAFE1.DEA0DA6D@wanadoo.fr>; from jean-luc.coulon@wanadoo.fr on Thu, May 10, 2001 at 05:12:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2001 at 05:12:33PM +0200, Jean-Luc Coulon wrote:

> >Huh.  Does it do the same thing every time you load parport_probe?
> >Does it always get truncated in the same place?
>=20
> Yes ! :-/

Nothing really uses that information in 2.2 anyway, so it's harmless
at least.  It's probably a timing thing; take a look at the
differences between the 2.2 and 2.4 code for that.

Tim.
*/

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BFdgONXnILZ4yVIRAgvhAJ90zdfOWII3eC7wNEoLb09Uu5rsfQCghTwy
dm4lrJuyed+4G8s76QnFzWM=
=gKNg
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
