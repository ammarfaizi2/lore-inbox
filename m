Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTJ1Tge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJ1Tge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:36:34 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5249 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261660AbTJ1Tgd (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:36:33 -0500
Message-Id: <200310281936.h9SJaS6P004298@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-* 
In-Reply-To: Your message of "Tue, 28 Oct 2003 10:20:08 PST."
             <Pine.LNX.4.44.0310281019280.1023-100000@cherise> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310281019280.1023-100000@cherise>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1517372808P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Oct 2003 14:36:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1517372808P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Oct 2003 10:20:08 PST, Patrick Mochel said:

> I posted the patch below to the linux-acpi list a few weeks ago. It causes
> /sbin/hotplug to be called on both suspend and resume. It's a lightweight,
> non-intrusive notification mechanism that allows only the applications
> that care about the events be notified of the transition.

Untested yet, but it appears to be sufficient for what my config needs. Thanks.

--==_Exmh_-1517372808P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/nsU8cC3lWbTT17ARAvVIAJ9EwFYUr6UzTnTFMBmlmKe4IC3AzQCffB3o
vXUi7LRki2YZa/1ai9qmqYI=
=L8pk
-----END PGP SIGNATURE-----

--==_Exmh_-1517372808P--
