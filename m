Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTHTSrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTHTSql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:46:41 -0400
Received: from h80ad24cb.async.vt.edu ([128.173.36.203]:15233 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262160AbTHTSqf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:46:35 -0400
Message-Id: <200308201846.h7KIkSuu013919@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console on USB 
In-Reply-To: Your message of "Wed, 20 Aug 2003 11:07:42 PDT."
             <20030820110742.0cd0160a.rddunlap@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200308201745.SAA23241@mauve.demon.co.uk> <200308201756.h7KHuJuu012039@turing-police.cc.vt.edu>
            <20030820110742.0cd0160a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_482808040P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Aug 2003 14:46:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_482808040P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Aug 2003 11:07:42 PDT, "Randy.Dunlap" said:

> I don't see any console support in the irda drivers...
> How is it supposed to work?
> or do you just mean that in theory it could be made to work?

Well, in theory..   The problem is that for irda to work, you'd need a *second*
device that did irda to catch the bits - and I don't have a good feel for how
many of the kernel hackers that would use this have a second irda-capable box -
probably a lot less than have a second box that does USB....

Now if that damned RJ-11 for the LoseModem was useful for something... ;)





--==_Exmh_482808040P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Q8IEcC3lWbTT17ARAu2bAKDHntsy6HLOKk/wkrfMPiWUCknATQCbB5hw
iVL0Yl+rpuK+Fc3hUxj58+E=
=OY57
-----END PGP SIGNATURE-----

--==_Exmh_482808040P--
