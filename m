Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUBHTGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 14:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBHTGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 14:06:16 -0500
Received: from [193.170.124.123] ([193.170.124.123]:21336 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S264365AbUBHTGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 14:06:14 -0500
Date: Sun, 8 Feb 2004 20:05:43 +0100
From: JG <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: Re: could someone plz explain those ext3/hard disk errors
In-Reply-To: <20040208185549.GC7581@luna.mooo.com>
References: <20040208175346.767881A96E1@23.cms.ac>
	<20040208185549.GC7581@luna.mooo.com>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__8_Feb_2004_20_05_44_+0100_7gfJ/FnG7_MY/OSC"
Message-Id: <20040208190613.75D131A9AB1@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__8_Feb_2004_20_05_44_+0100_7gfJ/FnG7_MY/OSC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

thanks for your anwser!

> It could be power surges. Hard disks are very sensitive to that.
> 
> Also have you run fsck on these disks ? could it be that you are not
> shutting them down properly?

i'm using an enermax 550W PSU attached to a APC UPS, at the moment there are 10 disks and 1 cdrom in the server.
the server is usually running 24/7 but i had some crashes within the last weeks due to hard disk failures so it might be possible that the other disks were affected. i don't dare to fsck the disks now because i couldn't backup the data yet (no spare disks) and i have lost too much data because of fsck'ing my hard disks in the past.

JG

--Signature=_Sun__8_Feb_2004_20_05_44_+0100_7gfJ/FnG7_MY/OSC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJoikU788cpz6t2kRAqOYAJ9FjyBB3snDaz1g5wZb05uLCntq+gCfd0jG
mA6yRVhUY48kWZwmCpUtBLk=
=Sm84
-----END PGP SIGNATURE-----

--Signature=_Sun__8_Feb_2004_20_05_44_+0100_7gfJ/FnG7_MY/OSC--
