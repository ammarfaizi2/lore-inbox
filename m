Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNXXD>; Thu, 14 Dec 2000 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbQLNXWx>; Thu, 14 Dec 2000 18:22:53 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:56730 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129773AbQLNXWt>; Thu, 14 Dec 2000 18:22:49 -0500
Date: Thu, 14 Dec 2000 22:52:20 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Peter Bornemann <eduard.epi@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport1 gone in 2.2.18
Message-ID: <20001214225220.H1424@redhat.com>
In-Reply-To: <20001213231332.P5918@redhat.com> <Pine.LNX.4.21.0012142026150.684-100000@eduard.t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012142026150.684-100000@eduard.t-online.de>; from eduard.epi@t-online.de on Thu, Dec 14, 2000 at 08:43:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2000 at 08:43:18PM +0100, Peter Bornemann wrote:

> Any hint is welcome, for I would prefer a really stable kernel for this
> machine.

The problem isn't that the kernel is not stable, but that it doesn't
support your parallel port card. ;-)

I'll look at backporting the 2.4.x card table and keep you posted.

Tim.
*/

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OU8kONXnILZ4yVIRAi/GAJ9jfE3PU8wa+2b8eNrcrV8N4M4EpgCfeqY5
A923sFCiJfJMJH+lfpC1KjA=
=RRvQ
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
