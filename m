Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTKJQ3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTKJQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:29:18 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8320 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263957AbTKJQ3Q (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:29:16 -0500
Message-Id: <200311101629.hAAGTAwi002657@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any thoughts when 2.6.0-test10 is due? 
In-Reply-To: Your message of "Mon, 10 Nov 2003 09:56:39 GMT."
             <5.2.0.9.0.20031110095312.00b3dea0@mailhost.ivimey.org> 
From: Valdis.Kletnieks@vt.edu
References: <5.2.0.9.0.20031110095312.00b3dea0@mailhost.ivimey.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1623194150P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Nov 2003 11:29:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1623194150P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Nov 2003 09:56:39 GMT, Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>  said:
> ... It's been a couple of weeks since -test9 came out, and I'd quite like 
> to get a kernel that includes the various good patches that have been 
> proposed since then.

Make note that a lot of the more intrusive patches will be deferred to 2.6.1,
which will have a patch easily 10x the size of the -test[789] ones (Linus
is being intentionally very picky about what goes into the tree).  I'm
going to predict that the 2.6.0->2.6.1 patch will be well over a megabyte
even after gzipping.

--==_Exmh_-1623194150P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/r7zWcC3lWbTT17ARAtvgAKCU+yrNiQIjDDgQ1M7Yc1dRv1ty3ACgxdLI
TAOylORu4UE6flw04VM0em0=
=yKQv
-----END PGP SIGNATURE-----

--==_Exmh_-1623194150P--
