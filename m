Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTEYEfu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTEYEfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:35:50 -0400
Received: from [128.173.39.63] ([128.173.39.63]:43136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261322AbTEYEft (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:35:49 -0400
Message-Id: <200305250448.h4P4mqoH005720@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Fix NMI watchdog documentation 
In-Reply-To: Your message of "Sat, 24 May 2003 23:36:26 EDT."
             <Pine.LNX.4.50.0305242335090.17353-100000@montezuma.mastecende.com> 
From: Valdis.Kletnieks@vt.edu
References: <3ECFC2D6.2020007@gmx.net> <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com> <200305250329.h4P3TGoH004620@turing-police.cc.vt.edu>
            <Pine.LNX.4.50.0305242335090.17353-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1641657456P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 May 2003 00:48:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1641657456P
Content-Type: text/plain; charset=us-ascii

On Sat, 24 May 2003 23:36:26 EDT, Zwane Mwaikambo said:

> > Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.

> It's known broken with that configuration and hence blacklisted.

Yes, I know it's blacklisted.  The question I intended to ask was "Is the
entire concept of IOAPIC irretrievably scrozzled on this machine, or is there
sufficient minimum functionality to get nmi_watchdog working?"


--==_Exmh_-1641657456P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+0Es0cC3lWbTT17ARAm1MAJ9ozOLZYHxsKtTZNkm+ZlEbwb/T9gCgz1z4
guQLhtj8BebJq+YdyL31Yr8=
=brpc
-----END PGP SIGNATURE-----

--==_Exmh_-1641657456P--
