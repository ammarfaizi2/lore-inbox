Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbUALPFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266103AbUALPFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:05:17 -0500
Received: from h80ad25ab.async.vt.edu ([128.173.37.171]:32129 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265577AbUALPFK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:05:10 -0500
Message-Id: <200401121504.i0CF4Lp4018626@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dax Kelson <dax@gurulabs.com>
Cc: Bart Samwel <bart@samwel.tk>, Jan De Luyck <lkml@kcore.org>,
       linux-kernel@vger.kernel.org, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1 
In-Reply-To: Your message of "Mon, 12 Jan 2004 05:50:34 MST."
             <1073911834.2892.0.camel@mentor.gurulabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <3FFFD61C.7070706@samwel.tk> <200401121045.56749.lkml@kcore.org> <40026FEC.4040707@samwel.tk>
            <1073911834.2892.0.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-502760410P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jan 2004 10:04:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-502760410P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Jan 2004 05:50:34 MST, Dax Kelson said:
> On Mon, 2004-01-12 at 02:59, Bart Samwel wrote:
> > Jan De Luyck wrote:
> > > There seems to be a typo in the battery.sh script. It 
> > > reads /proc/acpi/ac_adapter/AC/state to determine the AC Adaptor state, b
ut 
> > > this is in the ACAD directory instead of the AC directory.
> > 
> > Hmmm, Dax says it works for him, and I don't have an ac_adapter on my 
> > machine because I don't own a laptop. Dax, is this a typo or is it 
> > actually called AC on your machine?
> 
> On my Dell Inspiron 4150 it is called AC not ACAD.

Dell Latitude C840 calls it /proc/acpi/ac_adapter/AC/state as well.


--==_Exmh_-502760410P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAArd1cC3lWbTT17ARAiBeAJ9oZYPj4uXvfyy+Q9W1stdsj3HvmQCfTERx
kSvCXIusCv6md7ei8FvZLVI=
=x1+m
-----END PGP SIGNATURE-----

--==_Exmh_-502760410P--
