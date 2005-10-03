Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVJCSbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVJCSbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVJCSbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:31:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:25809 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932475AbVJCSbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:31:40 -0400
Message-Id: <200510031831.j93IVQJT019379@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up 
In-Reply-To: Your message of "Mon, 03 Oct 2005 13:06:08 CDT."
             <1128362768.8967.10.camel@kleikamp.austin.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu> <20050923153158.GA4548@x30.random> <1127509047.8880.4.camel@kleikamp.austin.ibm.com> <1127509155.8875.6.camel@kleikamp.austin.ibm.com> <1127511979.8875.11.camel@kleikamp.austin.ibm.com> <20050928223829.GH10408@opteron.random> <1128126424.10237.7.camel@kleikamp.austin.ibm.com> <20051002102726.GB26677@opteron.random> <1128261072.9382.4.camel@kleikamp.austin.ibm.com>
            <1128362768.8967.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128364286_5142P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 14:31:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128364286_5142P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Oct 2005 13:06:08 CDT, Dave Kleikamp said:

> Unfortunately, this doesn't solve Valdis' problem, as he isn't using
> jfs.  Valdis, do you have any other file systems mounted besides ext3?
> I wonder if another file system has a similar problem.

Nope, all ext3 here..

--==_Exmh_1128364286_5142P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQXj+cC3lWbTT17ARAqZSAKDB9ymw1kScEuZxqgiN4LFLTNUBwgCg2cId
N1+R+tdsG1sR5jh5KjRRoG4=
=k2u7
-----END PGP SIGNATURE-----

--==_Exmh_1128364286_5142P--
