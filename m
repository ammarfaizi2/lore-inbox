Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131704AbQKTOu0>; Mon, 20 Nov 2000 09:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbQKTOuQ>; Mon, 20 Nov 2000 09:50:16 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33141 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131938AbQKTOuL>; Mon, 20 Nov 2000 09:50:11 -0500
Date: Mon, 20 Nov 2000 14:20:09 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Oleg Makarenko <omakarenko@cyberplat.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre22: ppa_fail(3) from ppa_wait at line 319
Message-ID: <20001120142009.Z20970@redhat.com>
In-Reply-To: <3A192EBC.F5B048F2@cyberplat.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="aEcIyhw0mmnxygNd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A192EBC.F5B048F2@cyberplat.ru>; from omakarenko@cyberplat.ru on Mon, Nov 20, 2000 at 05:01:32PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aEcIyhw0mmnxygNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2000 at 05:01:32PM +0300, Oleg Makarenko wrote:

> the following partial reversal patch seems to help (but I am not sure it
> is correct):

Hmm.  That patch went in because without it it doesn't work at all for
some people. :-((

Tim.
*/

--aEcIyhw0mmnxygNd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6GTMYONXnILZ4yVIRAo6oAJ9mJt1OKfYJ6FB+AkRWRjXhPTPMBwCgil+V
P+72jDmR5UlzLvPBEVP3vXI=
=Qidw
-----END PGP SIGNATURE-----

--aEcIyhw0mmnxygNd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
