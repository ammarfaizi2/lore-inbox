Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVGIRex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVGIRex (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 13:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVGIRex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 13:34:53 -0400
Received: from h80ad2581.async.vt.edu ([128.173.37.129]:37330 "EHLO
	h80ad2581.async.vt.edu") by vger.kernel.org with ESMTP
	id S261634AbVGIRew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 13:34:52 -0400
Message-Id: <200507091734.j69HYerL005546@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lance <molecularbiophysics@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-kernel Cannot determine dependencies of module piix 
In-Reply-To: Your message of "Sat, 09 Jul 2005 12:16:46 +0200."
             <a015f9a005070903165a6248fd@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <a015f9a005070903165a6248fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1120930478_8886P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Jul 2005 13:34:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1120930478_8886P
Content-Type: text/plain; charset=us-ascii

On Sat, 09 Jul 2005 12:16:46 +0200, Lance said:

> I  get the message "Cannot determine dependencies of module piix"
> while running mkinitrd. My apologies that this might me a very
> "newbie" question. (until now I have compiled upto 2.6.11.12 without
> any problems.

man depmod

You've probably managed to corrupt the modules.dep file somehow.

--==_Exmh_1120930478_8886P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC0AqucC3lWbTT17ARApXFAKDEnstv5/7FhpggQ8MBMaVgF5I+FgCePmDv
LG8Y2FqijuP6mRstR31gnVQ=
=3Gmg
-----END PGP SIGNATURE-----

--==_Exmh_1120930478_8886P--
