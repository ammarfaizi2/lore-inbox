Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVECUKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVECUKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVECUKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 16:10:32 -0400
Received: from h80ad252c.async.vt.edu ([128.173.37.44]:37393 "EHLO
	h80ad252c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261674AbVECUK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 16:10:26 -0400
Message-Id: <200505032009.j43K9qQJ023179@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: Haoqiang Zheng <haoqiang@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: question about contest benchmark 
In-Reply-To: Your message of "Tue, 03 May 2005 14:29:59 EDT."
             <1115144999.29445.7.camel@mindpipe> 
From: Valdis.Kletnieks@vt.edu
References: <d6e6e6dd05050311115d256213@mail.gmail.com>
            <1115144999.29445.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115150991_3418P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 May 2005 16:09:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115150991_3418P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 May 2005 14:29:59 EDT, Lee Revell said:

> But, it seems to me that even if an interactive process briefly goes CPU
> bound (due to bloat, bugs, or intent), it should still be scheduled
> preferentially to a pure CPU bound process like a build.

So you want it to schedule that big image (Evolution) that's already used 5
minutes of CPU since it started (this morning, admittedly) in preference to
that cc1 process that will be gone before it's used 2 seconds of CPU, plus all
the disk I/O that cc1 performs (hopefully the cache will help here, but it may
indeed go to disk to read the source files)?


--==_Exmh_1115150991_3418P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCd9qPcC3lWbTT17ARAq25AJ9xBIOm89gdTh8kmEfC8cQWh+pFswCg2lB9
shjcg0AELsNxWWubRmB02n8=
=Hz5r
-----END PGP SIGNATURE-----

--==_Exmh_1115150991_3418P--
