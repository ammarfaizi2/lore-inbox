Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTKXV26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKXV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:28:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37510 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261538AbTKXV2y (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:28:54 -0500
Message-Id: <200311242128.hAOLSqKL011458@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tilo Lutz <TiloLutz@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't login with kernel 2.6 
In-Reply-To: Your message of "Mon, 24 Nov 2003 22:59:38 +0100."
             <1069711178.2331.8.camel@tilo.rz.uni-karlsruhe.de> 
From: Valdis.Kletnieks@vt.edu
References: <1069711178.2331.8.camel@tilo.rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2123481556P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Nov 2003 16:28:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2123481556P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Nov 2003 22:59:38 +0100, Tilo Lutz <TiloLutz@gmx.de>  said:

> A script to set up network has shown an error:
> chown root:root user unknown.
> I also get en error: /dev/tty unknown device.

Shot in the dark - you didn't accidentally enable the SElinux stuff
and fail to make all the appropriate userspace changes, did you?

--==_Exmh_2123481556P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/wngUcC3lWbTT17ARAq68AKDodbKBDivTN83Zt6G01MR17wdq+wCfUiU+
L9Bu85900M41k7n4bJmsp/4=
=WFWN
-----END PGP SIGNATURE-----

--==_Exmh_2123481556P--
