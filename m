Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVFTTmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVFTTmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVFTTjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:39:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:2573 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261530AbVFTTjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:39:05 -0400
Message-Id: <200506201938.j5KJcibm004060@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Paradise <paradyse@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Debian Users List <debian-user@lists.debian.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 cannot build nvidia driver? 
In-Reply-To: Your message of "Tue, 21 Jun 2005 03:00:45 +0800."
             <f2176eb80506201200bb50ef1@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <f2176eb805062004557fc7b9ac@mail.gmail.com> <f2176eb805062005201c96510a@mail.gmail.com> <200506201639.j5KGdoNO016276@turing-police.cc.vt.edu> <f2176eb805062012003b068199@mail.gmail.com>
            <f2176eb80506201200bb50ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119296324_14097P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jun 2005 15:38:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119296324_14097P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Jun 2005 03:00:45 +0800, Paradise said:
> *version of 1.0.7174-3 from debian* 

Sorry, I was looking at 7664 - you might try using the more recent driver
and seeing if that helps.  Presumably the fixed #ifdef's in the newer code
will work better....

--==_Exmh_1119296324_14097P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCtxtEcC3lWbTT17ARAhb+AJ4uaXyAA6OXHpRrj9FyR2jpVFaRnACcDAad
N8UfUOxyzWX9xS1xi6s9ipA=
=Oa4p
-----END PGP SIGNATURE-----

--==_Exmh_1119296324_14097P--
