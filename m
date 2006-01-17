Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWAQVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWAQVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAQVG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:06:29 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44709 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932408AbWAQVG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:06:29 -0500
Message-Id: <200601172106.k0HL6LMW008241@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1 
In-Reply-To: Your message of "Tue, 17 Jan 2006 00:19:56 PST."
             <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137531981_3292P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 16:06:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137531981_3292P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 Jan 2006 00:19:56 PST, Linus Torvalds said:

> And largish networking updates: there's a "common netfilter" setup now, 
> which you'll notice when you do "make config" or equivalent, since a lot 
> of the netfilter rules now work on ipv4 and/or ipv6 rather than having 
> separate (and duplicate) versions for each.

Hooray! Finally. ;)

Does this require modprobing of the modules by hand, or is there a version
of iptables in the pipe that knows how to do this?  I checked the CVS snapshot
directory on ftp.netfilter.org last night, and the latest one there didn't
know about this yet.

--==_Exmh_1137531981_3292P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFDzVxNcC3lWbTT17ARArgiAKDBeVAYIBWb/rkLGIDIphJ38bCB/QCY4d4d
iA011K1yduS0Mj1SXe945A==
=laqF
-----END PGP SIGNATURE-----

--==_Exmh_1137531981_3292P--
