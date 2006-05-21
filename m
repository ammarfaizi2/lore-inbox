Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWEUFin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWEUFin (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 01:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWEUFin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 01:38:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35045 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751476AbWEUFin (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 01:38:43 -0400
Message-Id: <200605210538.k4L5ccJ1001005@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm2
In-Reply-To: Your message of "Sun, 21 May 2006 01:19:20 EDT."
             <Pine.LNX.4.64.0605210119060.25962@d.namei>
From: Valdis.Kletnieks@vt.edu
References: <20060520054103.46a6edb5.akpm@osdl.org> <200605210428.k4L4S0nv013532@turing-police.cc.vt.edu>
            <Pine.LNX.4.64.0605210119060.25962@d.namei>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148189918_32020P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 21 May 2006 01:38:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148189918_32020P
Content-Type: text/plain; charset=us-ascii

On Sun, 21 May 2006 01:19:20 EDT, James Morris said:
> On Sun, 21 May 2006, Valdis.Kletnieks@vt.edu wrote:

> > Was it *really* intended that SELINUX not be selectable if NETWORK_SECMARK
> > isn't present?
> 
> Yes, it's required for SELinux.

Could stand a SELECT instead, then?

--==_Exmh_1148189918_32020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEb/zecC3lWbTT17ARAoGLAKC3wTKqlU1EeEecN6UeRNwiG25JcACgjKKa
azR5RgRejnTbMqDvJHHcIQs=
=yAu1
-----END PGP SIGNATURE-----

--==_Exmh_1148189918_32020P--
