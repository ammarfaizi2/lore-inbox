Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130134AbQKZAZh>; Sat, 25 Nov 2000 19:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130423AbQKZAZ1>; Sat, 25 Nov 2000 19:25:27 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:3376 "EHLO
        lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
        id <S130134AbQKZAZP>; Sat, 25 Nov 2000 19:25:15 -0500
Date: Sat, 25 Nov 2000 23:55:11 +0000
From: Tim Waugh <twaugh@redhat.com>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: Andries Brouwer <aeb@veritas.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001125235511.A16662@redhat.com>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com> <0011252259430A.11866@dax.joh.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0011252259430A.11866@dax.joh.cam.ac.uk>; from jas88@cam.ac.uk on Sat, Nov 25, 2000 at 10:53:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 25, 2000 at 10:53:00PM +0000, James A Sutherland wrote:

> Which is silly. The variable is explicitly defined to be zero
> anyway, whether you put this in your code or not.

Why doesn't the compiler just leave out explicit zeros from the
'initial data' segment then?  Seems like it ought to be tought to..

Tim.
*/

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6IFFeONXnILZ4yVIRAoWyAKCBBB6M1cH/kctuX333mT1SSbgGKgCfaJEg
BiM+ZnYSz9bFEPMr+1fxAyE=
=aaMM
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
