Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUEFQaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUEFQaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEFQaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:30:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60548 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261206AbUEFQ3v (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:29:51 -0400
Message-Id: <200405061629.i46GTm2x018759@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK) 
In-Reply-To: Your message of "Thu, 06 May 2004 17:40:33 +0200."
             <1083858033.3844.6.camel@laptop.fenrus.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
            <1083858033.3844.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1015874428P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 May 2004 12:29:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1015874428P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 May 2004 17:40:33 +0200, Arjan van de Ven said:
> Ok I don't want to start a flamewar but... Do we want to hold linux back
> until all binary only module vendors have caught up ??

No.. I merely suggested that coordinating with as few as possibly one vendor to
clean their module up might minimize the pain considerably.  NVidia is aware of
the issue, and rumor has it that the 6xxx series of Linux drivers are targeted
for the end of May and will have a fix for the 4K stack (which is an issue for
the Fedora Core 2 release already) since they need to push out a revision to
support the 6800 series cards anyhow....




--==_Exmh_1015874428P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAmmf8cC3lWbTT17ARAi6HAKDbJDv1ge1iwQyDnW/3I5MOkw0a6ACg2WWf
J+e5M8mlz+i5qOuq3egCW+k=
=HT+F
-----END PGP SIGNATURE-----

--==_Exmh_1015874428P--
