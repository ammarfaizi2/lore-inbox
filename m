Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVDZDo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVDZDo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDZDo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:44:58 -0400
Received: from h80ad2469.async.vt.edu ([128.173.36.105]:16913 "EHLO
	h80ad2469.async.vt.edu") by vger.kernel.org with ESMTP
	id S261293AbVDZDou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:44:50 -0400
Message-Id: <200504260344.j3Q3ia4l009527@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Florian Engelhardt <flo@dotbox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3 and bttv -> kernel panic 
In-Reply-To: Your message of "Mon, 25 Apr 2005 23:54:08 +0200."
             <20050425235408.208edf38@discovery.hal.lan> 
From: Valdis.Kletnieks@vt.edu
References: <20050425235408.208edf38@discovery.hal.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114487074_3571P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Apr 2005 23:44:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1114487074_3571P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Apr 2005 23:54:08 +0200, Florian Engelhardt said:

> Of course the nvidia-kernel module does not work right with the 2.6.12-
> rc2-mm3 kernel. I can modprobe it, but if i try to start the X-Server,
> it tells me, that it is unable to load the kernel module (allthough it
> is allready loaded)

NVidia driver 7167 and 7174 work just fine with 2.6.12-rc2-mm3, at least for
some people. If it's not working for you, that's an NVidia problem, not a lkml
one.  If you need help, yell off-list and I'll see what I can do, or go to the
NVidia page the drivers are on, and follow the 'Forums' link - that's a *very*
good source for assistance and patches..


--==_Exmh_1114487074_3571P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCbbkicC3lWbTT17ARArHtAJ41BpgWwYozXkgmK/pYyf3FA7QDBgCeI+rB
NGEYmPkNlGrQtwROz7iKoIU=
=3h2W
-----END PGP SIGNATURE-----

--==_Exmh_1114487074_3571P--
