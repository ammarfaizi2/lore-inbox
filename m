Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWG0BcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWG0BcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWG0BcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:32:16 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:5062
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750771AbWG0BcQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:32:16 -0400
Message-Id: <200607270132.k6R1W7O4006409@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Al Boldi <a1426z@gawab.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
In-Reply-To: Your message of "Wed, 26 Jul 2006 17:04:35 +0300."
             <200607261704.35399.a1426z@gawab.com>
From: Valdis.Kletnieks@vt.edu
References: <200607241857.52389.a1426z@gawab.com> <200607261423.03527.a1426z@gawab.com> <200607261234.k6QCY7Eb022487@turing-police.cc.vt.edu>
            <200607261704.35399.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153963927_4728P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 21:32:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153963927_4728P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Jul 2006 17:04:35 +0300, Al Boldi said:

> The important part here is 'unless there is a way to relate them', at which 
> point UP and MP should be conceptually the same, while possibly differing in 
> the implementation details.

Oh, OK. I think we're actually in agreement, just using different terms for
the same thing - what you were considering multiple related queues, I'd
consider one unified queue with subqueuing of some sort.. ;)

--==_Exmh_1153963927_4728P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyBeXcC3lWbTT17ARAkFcAKCT4nzeb0hL7vBViNsW0M82UrRCrwCfcpsu
OMlaotKzJ1RV1fEMXrKm72c=
=GtGr
-----END PGP SIGNATURE-----

--==_Exmh_1153963927_4728P--
