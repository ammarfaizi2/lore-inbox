Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDGTEW>; Sat, 7 Apr 2001 15:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRDGTEM>; Sat, 7 Apr 2001 15:04:12 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:22830 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130317AbRDGTEF>; Sat, 7 Apr 2001 15:04:05 -0400
Date: Sat, 7 Apr 2001 20:03:40 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org, mj@suse.cz, reinelt@eunet.at,
        jgarzik@mandrakesoft.com
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
Message-ID: <20010407200340.C3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF5F9B.AA42F1BD@t-online.de>; from Gunther.Mayer@t-online.de on Sat, Apr 07, 2001 at 08:42:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 07, 2001 at 08:42:35PM +0200, Gunther Mayer wrote:

> Please apply this little patch instead of wasting time by
> finger-pointing and arguing.

This patch would make me happy.

It would allow support for new multi-IO cards to generally be the
addition of about two lines to two files (which is currently how it's
done), rather than having separate mutant hybrid monstrosity drivers
for each card (IMHO)..

Tim.
*/

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2SLONXnILZ4yVIRAsfdAJ46NzuMmsfUtbD10Pxy4Gc+hvWtNgCfVJv0
8s656jmDEbDyZUdhCtKL1mQ=
=m+W5
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
