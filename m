Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268246AbTBNIt4>; Fri, 14 Feb 2003 03:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268247AbTBNIt4>; Fri, 14 Feb 2003 03:49:56 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:40147 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268246AbTBNItz>; Fri, 14 Feb 2003 03:49:55 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: NO BOOT since 2.5.60-bk1
Date: Fri, 14 Feb 2003 09:59:37 +0100
User-Agent: KMail/1.5
Cc: Michael Stolovitzsky <romat8@netvision.net.il>,
       linux-kernel@vger.kernel.org
References: <200302131507.37380.schlicht@uni-mannheim.de> <200302132007.38595.schlicht@uni-mannheim.de> <20030213205956.GA24361@codemonkey.org.uk>
In-Reply-To: <20030213205956.GA24361@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_+/KT+Z/1UPSYthw";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302140959.43126.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_+/KT+Z/1UPSYthw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

On Thursday, 13. February 2003 21:59, Dave Jones wrote:
> Can you try -bk3 ?
> It may have contained some of the signal fixes that went in recently.
> I'm not sure how many of those made it into -bk1/bk2.
>
> 		Dave

Sorry for the delay, but this machine compiles slowly... ;-)
And you were right, the problem is fixed in -bk3!

Thanks alot!

  Thomas
--Boundary-02=_+/KT+Z/1UPSYthw
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TK/+YAiN+WRIZzQRAo3BAJ9D/bWtGmMR+LAa6v3OCGBRqVmoSACfY5yg
a4D91Bmx5Bj7XJ+geZy8wJQ=
=ZYc7
-----END PGP SIGNATURE-----

--Boundary-02=_+/KT+Z/1UPSYthw--

