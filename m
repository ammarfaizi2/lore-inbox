Return-Path: <linux-kernel-owner+w=401wt.eu-S1423007AbWLUSRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423007AbWLUSRU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423005AbWLUSRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:17:20 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55259 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422999AbWLUSRU (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:17:20 -0500
Message-Id: <200612211816.kBLIGFdf024664@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
In-Reply-To: Your message of "Wed, 20 Dec 2006 23:06:43 +0100."
             <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net>
From: Valdis.Kletnieks@vt.edu
References: <loom.20061215T220806-362@post.gmane.org> <200612162007.32110.marekw1977@yahoo.com.au> <4587097D.5070501@opensound.com>
            <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166724975_12674P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Dec 2006 13:16:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166724975_12674P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Dec 2006 23:06:43 +0100, Giuseppe Bilotta said:

> So while what you say is perfectly sensible for *software* developers,
> it has absolutely nothing to do with the closed source drivers
> *hardware* companies distribute.

The problem is that the software drivers reveal an awful lot about the
innards of the hardware, which is something the hardware companies *do*
want to protect.

> This all being said, I think that the only thing that can shake
> companies such as nVidia and ATI is a project such as the Open
> Graphics Card

At least nVidia *does* actually Get It, they just don't have a choice in
implementing it, because all their current hardware includes patents that
they licensed from other companies (I believe some of the OpenGL stuff that
originated at SGI and got bought by Microsoft is involved, but I have no
hard references for actual patent numbers).  And then they have the big
problem - do they keep using the patent in order to boost performance,
or no?

If they produce a blazing-fast card and they manage to sell to 30% of the
Windows users, they've sold to about 27% of all computer users.  If they
skip the patent and produce a slower card to please the Linux users, even if
they sell to half the Linux users, that's only 5-6% of the market.

Which course of action is any CFO going to choose?

(And let's not underestimate the possibility that some yet-undisclosed
submarine patent will torpedo the Open Graphics Card if they unwittingly
re-invent something owned by a company that wants the card to fail....)

--==_Exmh_1166724975_12674P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFis9vcC3lWbTT17ARAimzAKCU8mhvQEOWQwhdervMau931pb35gCg7Q67
w9U6y7YBseM7kMjgdRmS4uI=
=SJjX
-----END PGP SIGNATURE-----

--==_Exmh_1166724975_12674P--
