Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTKQPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTKQPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:07:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:14208 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263541AbTKQPH0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:07:26 -0500
Message-Id: <200311171507.hAHF7INt007210@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Wilmer van der Gaast <lintux@lintux.cx>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Configuration help texts for IPsec 
In-Reply-To: Your message of "Mon, 17 Nov 2003 15:57:23 +0100."
             <20031117145723.GB1268@gaast.net> 
From: Valdis.Kletnieks@vt.edu
References: <20031115150841.GA4854@gaast.net> <Xine.LNX.4.44.0311170948100.1445-100000@thoron.boston.redhat.com>
            <20031117145723.GB1268@gaast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-921482272P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Nov 2003 10:07:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-921482272P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Nov 2003 15:57:23 +0100, Wilmer van der Gaast said:

> Shouldn't the text "If unsure, say Y." be more like "If you want to use
> IPsec, you need this."? Possibly with an addition like "If you don't
> know what IPsec is, you don't need it."?

A lot of people don't have the foggiest idea what IPsec is, but do
know they're trying to use a VPN.  Probably need to include that in there,
if you're trying to do anything with the help text.

--==_Exmh_-921482272P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/uOQmcC3lWbTT17ARAjuIAJ98kqkFEhlpcwoQWkSdVCBt65PumwCg1+5F
tZahCIN6uKggCRv7iaPKKpA=
=zozf
-----END PGP SIGNATURE-----

--==_Exmh_-921482272P--
