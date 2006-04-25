Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWDYTJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWDYTJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDYTJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:09:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53996 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751267AbWDYTJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:09:42 -0400
Message-Id: <200604251909.k3PJ9KJc008091@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chris Boot <bootc@bootc.net>
Cc: Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, drepper@gmail.com,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries 
In-Reply-To: Your message of "Tue, 25 Apr 2006 20:01:24 BST."
             <9C02B13C-8615-440B-A08C-AC463CC2E0AE@bootc.net> 
From: Valdis.Kletnieks@vt.edu
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
            <9C02B13C-8615-440B-A08C-AC463CC2E0AE@bootc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145992160_2618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 15:09:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145992160_2618P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Apr 2006 20:01:24 BST, Chris Boot said:

> Wouldn't you need to sign, say, /lib/ld-linux.so? In that case, you  
> can simply get it to load an execute almost anything that's ELF, even  
> on filesystems marked noexec, if I'm not mistaken...

2.6.0 included a fix to stop that from working from noexec filesystems.

--==_Exmh_1145992160_2618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETnPgcC3lWbTT17ARAtXBAJ41vMgh8sHuOV0myAxvhkY2vpVDbwCgrbdn
LusCZz5fIWIAapR2amQXyXU=
=R1ZR
-----END PGP SIGNATURE-----

--==_Exmh_1145992160_2618P--
