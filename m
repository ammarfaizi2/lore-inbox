Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUJGVhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUJGVhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUJGVf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:35:57 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52353 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268224AbUJGVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:35:12 -0400
Message-Id: <200410072135.i97LZ18n008420@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358 
In-Reply-To: Your message of "Thu, 07 Oct 2004 16:48:42 EDT."
             <Pine.LNX.4.61.0410071640250.3287@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com> <1097175903.29576.12.camel@localhost.localdomain> <1097175596.31547.111.camel@localhost.localdomain>
            <Pine.LNX.4.61.0410071640250.3287@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_106308423P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 17:35:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_106308423P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Oct 2004 16:48:42 EDT, "Richard B. Johnson" said:

> Naaah. I included it in my module as a joke. Steve didn't take
> it as a joke and forwarded it to you. It shows that the whole
> MODULE_LICENSE("Whatever") is a joke. Not only that, I can
> simply change /proc/sys/kernel/tainted to 0 before submitting
> a bug report.

Hey. It's your conscience.  Personally, I rank it right up there with
lying to your physician regarding your symptoms, and for the same reasons.

As for shipping code like that - that's just downright dishonest.

--==_Exmh_106308423P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZbaFcC3lWbTT17ARAuDeAKDW/RvEsu6Wa/TUUVtExZBFL87DMACfbVzV
d5B6nQCbpsHWa+qIe3CzDQs=
=OJft
-----END PGP SIGNATURE-----

--==_Exmh_106308423P--
