Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbTIGA4p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 20:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTIGA4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 20:56:45 -0400
Received: from h80ad253e.async.vt.edu ([128.173.37.62]:29826 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262981AbTIGA4o (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 20:56:44 -0400
Message-Id: <200309070021.h870LaJe027827@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRYPTO] add alg. type to /proc/crypto output 
In-Reply-To: Your message of "Sat, 06 Sep 2003 12:08:18 +0200."
             <20030906100818.GA24931@johanna5.ux.his.no> 
From: Valdis.Kletnieks@vt.edu
References: <20030905143859.GA18143@johanna5.ux.his.no> <20030905073403.0b939b0a.davem@redhat.com>
            <20030906100818.GA24931@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_760058760P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Sep 2003 20:21:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_760058760P
Content-Type: text/plain; charset=us-ascii

On Sat, 06 Sep 2003 12:08:18 +0200, Erlend Aasland said:
> On 09/05/03 07:34, David S. Miller wrote:

> > When you see names like "md5" and parameters such as "digestsize"
> > listed, do you really have no clue that it is a "digest"?  :-)
> Good point.

On the flip side, it makes it possible for an *AUTOMATED* process to search for
appropriate types of entries.  So for instance, a GUI can say "The following
3 digest functions are available, please choose one" or "The following 4 symmetric
encryptions are available".....

--==_Exmh_760058760P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/WnoQcC3lWbTT17ARAnATAKDJMshdyPKIjriMfuSwXiOp/X9JwgCglshY
9z2Xg23pKa3JsLpT3HlwU8E=
=O5jI
-----END PGP SIGNATURE-----

--==_Exmh_760058760P--
