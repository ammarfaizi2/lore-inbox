Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSCEWGg>; Tue, 5 Mar 2002 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSCEWGY>; Tue, 5 Mar 2002 17:06:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27999 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287421AbSCEWGM>; Tue, 5 Mar 2002 17:06:12 -0500
Date: Tue, 5 Mar 2002 22:04:00 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Bill Davidsen <davidsen@prodigy.com>, Mikael Pettersson <mikpe@csd.uu.se>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.18-pre/rc broke PLIP
Message-ID: <20020305220359.B8959@redhat.com>
In-Reply-To: <20020305165533.A1195@redhat.com> <Pine.LNX.3.96.1020305155013.28458A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020305155013.28458A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Mar 05, 2002 at 04:20:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2002 at 04:20:25PM -0500, Bill Davidsen wrote:

> 1 - didn't try, I checked that the patch had not been reverted, and
>     assumed that if it was broken and not changed it was broken still.
>     And I only looked in pre2-ac2, if it was fixed and Alan patched it
>     back broken.

Well, try it.  The correct patch is in there.

> 2 - understanding vast stretches of uncommented code you may need to
>     change is worthwhile reading. The corolary is that comments are worthwhile
>     typing.

(You must have missed the ChangeLog.)

Tim.
*/

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hUDPyaXy9qA00+cRAiXTAKCIwHlkjL/R8KkdzXZJuk53Ku9a6gCeM1dF
MLYIOKrUOEn4CG5yACzCMq4=
=97EK
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
