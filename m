Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWDFEGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWDFEGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDFEGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:06:15 -0400
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:18366 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751147AbWDFEGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:06:14 -0400
Message-Id: <200604060405.k36451P7006883@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules_install must not remove existing modules 
In-Reply-To: Your message of "Thu, 06 Apr 2006 00:12:29 +0200."
             <20060405221229.GA8972@mars.ravnborg.org> 
From: Valdis.Kletnieks@vt.edu
References: <200604052333.51085.agruen@suse.de>
            <20060405221229.GA8972@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1144296294_2641P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Apr 2006 00:04:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1144296294_2641P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Apr 2006 00:12:29 +0200, Sam Ravnborg said:

> I see no way to detect when it is OK to remove or not, so in the
> principle of least suprise I prefer having the removal unconditional for
> normal kernel builds, and no removal for external modules.

That sounds workable to me.

--==_Exmh_1144296294_2641P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFENJNmcC3lWbTT17ARAhSoAKDasQu35+25eSMd9u3/QLcpRQWTnACgpQ6K
3sqH1+mBnsuoMqkS4cCPP9Q=
=Utvc
-----END PGP SIGNATURE-----

--==_Exmh_1144296294_2641P--
