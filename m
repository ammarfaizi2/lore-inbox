Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbTC1Dod>; Thu, 27 Mar 2003 22:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTC1Dod>; Thu, 27 Mar 2003 22:44:33 -0500
Received: from starcraft.mweb.co.za ([196.2.45.78]:26596 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S262180AbTC1Doc>; Thu, 27 Mar 2003 22:44:32 -0500
Date: Fri, 28 Mar 2003 05:55:31 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Walt H <waltabbyh@comcast.net>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: vesafb problem
Message-Id: <20030328055531.7ee6ce73.bonganilinux@mweb.co.za>
In-Reply-To: <3E837B7D.9010005@comcast.net>
References: <3E8329D2.7040909@comcast.net>
	<20030327190222.GA4060@middle.of.nowhere>
	<3E835241.9060407@comcast.net>
	<20030327233902.5963b0b1.bonganilinux@mweb.co.za>
	<3E837B7D.9010005@comcast.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.3DLGQIP1cvji7p"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.3DLGQIP1cvji7p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2003 14:30:21 -0800
Walt H <waltabbyh@comcast.net> wrote:

> Bongani Hlope wrote:
> 
> > Strange I'm having the same problem, but I only have 256MB of memory and my GeForce 2 only has 32MB. This is what's on my messages file:
> > 
> > 
> > vesafb: framebuffer at 0xe0000000, mapped to 0xd0807000, size 32768k
> > vesafb: mode is 800x600x16, linelength=1600, pages=3
> > vesafb: protected mode interface info at c000:c060
> > vesafb: scrolling: redraw
> > vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> > Looking for splash picture.... found (800x600, 13683 bytes).
> > Console: switching to colour frame buffer device 82x30
> > fb0: VESA VGA frame buffer device
> > 
> 
> Hmmm. That's a different problem than I'm experiencing. Your system 
> appears to be correctly remapping the framebuffer and switching to it. 
> You don't get a graphical boot? Seems as if you should from the log 
> snippet you posted.


It is just black until X starts up, and if I try to switch to a virtual 
terminal I get a corrupt screen

--=.3DLGQIP1cvji7p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+g8fK+pvEqv8+FEMRAlc2AJ4itcTB+lXcGn/HAECDJ7P1qr97RQCeN+RJ
llFyCJl1Uxzf/xMkXx0kcVs=
=pfTM
-----END PGP SIGNATURE-----

--=.3DLGQIP1cvji7p--
