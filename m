Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTGWNJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270280AbTGWNJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:09:12 -0400
Received: from h80ad244e.async.vt.edu ([128.173.36.78]:6787 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270292AbTGWNJF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:09:05 -0400
Message-Id: <200307231324.h6NDO5qj009710@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Apurva Mehta <apurva@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: different behaviour with badblocks on 2.6.0-test1-mm1-07int 
In-Reply-To: Your message of "Wed, 23 Jul 2003 13:48:44 +0530."
             <20030723081844.GB1324@home.woodlands> 
From: Valdis.Kletnieks@vt.edu
References: <20030722214253.GD1176@matchmail.com>
            <20030723081844.GB1324@home.woodlands>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-206292700P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Jul 2003 09:24:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-206292700P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Jul 2003 13:48:44 +0530, Apurva Mehta <apurva@gmx.net>  said:

> On 2.6.0-test1, gkrellm does not show any disk usage at all for
> me. The disk usage krell just remains blank. vmstat reports expected
> usage though.

Upgrade your gkrellm - 2.1.14 is current.

2.1.6 Wed Jan 22, 2003
...
        * Patches:
          o Andreas Boman <aboman--at--eiwaz.com> had two Linux patches:
...
            - implemented reading disk stats from sysfs for recent 2.5.x kernels.


--==_Exmh_-206292700P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Hox0cC3lWbTT17ARAkFlAKCR3+7KT/8B+KWiKKnWmcdpIBbUogCggVbf
g6lBbbXicQytUqsMD4HL050=
=J8GD
-----END PGP SIGNATURE-----

--==_Exmh_-206292700P--
