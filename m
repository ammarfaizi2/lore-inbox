Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132332AbQKZRLX>; Sun, 26 Nov 2000 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132347AbQKZRLN>; Sun, 26 Nov 2000 12:11:13 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:53847 "EHLO
        lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
        id <S132332AbQKZRLA>; Sun, 26 Nov 2000 12:11:00 -0500
Date: Sun, 26 Nov 2000 16:40:58 +0000
From: Tim Waugh <twaugh@redhat.com>
To: John Cavan <johncavan@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11ac4
Message-ID: <20001126164058.B23819@redhat.com>
In-Reply-To: <E13zmwU-0001MJ-00@the-village.bc.nu> <3A203F0A.29336B56@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A203F0A.29336B56@home.com>; from johncavan@home.com on Sat, Nov 25, 2000 at 05:36:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 25, 2000 at 05:36:58PM -0500, John Cavan wrote:

> Just so I understand the differences, for learning purposes... Tim
> did this a little different than I did and I'd just like to
> understand the "whys" of it.

It's Douglas Gilbert's modified patch; Douglas explained that he
didn't find that dropping the io_request_lock for just
parport_enumerate was enough during his testing.

Tim.
*/

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6IT0ZONXnILZ4yVIRAmIVAJ0VeM9a9NXUZHBMVAbmtaHw+a4nnQCePRls
WX6Q2j3wexfn3pAH+OXVpoE=
=tROU
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
