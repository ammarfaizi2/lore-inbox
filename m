Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTKFUXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKFUXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:23:55 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32130 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263396AbTKFUXy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:23:54 -0500
Message-Id: <200311062023.hA6KNnHG005148@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: load 2.4.x binary only module on 2.6 
In-Reply-To: Your message of "Thu, 06 Nov 2003 15:05:28 EST."
             <200311061505.28953.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <20031106153004.GA30008@ds9.ch> <200311061433.12555.gene.heskett@verizon.net> <200311061952.hA6Jq9HG004043@turing-police.cc.vt.edu>
            <200311061505.28953.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-930887781P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Nov 2003 15:23:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-930887781P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Nov 2003 15:05:28 EST, Gene Heskett said:

> Very very easily done.  ctrl-alt-f2 to a shell.  It may, or may not 
> work.  crtl-alt-f7 back to X=locked up "tighter than Ft Knox" 
> computer, reset button or power button is all that works.

Odd.. That works fine for me as well (I often do that to go look and
see if exec-shield or ipfilters has tossed any odd messages).  I wonder
if it's because I'm using the vesafb framebuffer driver over there and you're
using something else? Or maybe the NVidia stuff happens to be stable for
the GeForce 440Go in my Dell laptop, but is wonky for your card/box?

--==_Exmh_-930887781P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qq3VcC3lWbTT17ARAnEyAJ0eXHJabH9N9VizjpKvSxGR8uYo6gCffcr4
WxmyRfOnN5MitgoBiQqK0Mk=
=7df0
-----END PGP SIGNATURE-----

--==_Exmh_-930887781P--
