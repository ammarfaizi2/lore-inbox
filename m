Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbTA3DSb>; Wed, 29 Jan 2003 22:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTA3DSb>; Wed, 29 Jan 2003 22:18:31 -0500
Received: from h80ad25d7.async.vt.edu ([128.173.37.215]:60288 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267388AbTA3DSa>; Wed, 29 Jan 2003 22:18:30 -0500
Message-Id: <200301300327.h0U3Rgfl002555@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/char/keyboard.c now unused? 
In-Reply-To: Your message of "Thu, 30 Jan 2003 15:41:15 +1300."
             <1043894474.1623.6.camel@laptop-linux.cunninghams> 
From: Valdis.Kletnieks@vt.edu
References: <1043894474.1623.6.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1645782888P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jan 2003 22:27:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1645782888P
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Jan 2003 15:41:15 +1300, Nigel Cunningham <ncunningham@clear.net.nz>  said:

> I've been doing some work on porting my patches to the 2.4 version of
> software suspend to 2.5. Under 2.4, I use the shift_state variable from
> drivers/char/keyboard.c to provide interactive, step-by-step progression
> through the process. That is, there is an option for you to be able to
> press and release shift before the next stage starts. With the new input

Barely related - is there anything that supports the shift_state stuff
for accessibility issues (for instance, people with too little mobility to
hold shift and a key at the same time)?  Or is that something that hasn't
even been looked at, or is the usual answer "Use an input method on the X
server"?

--==_Exmh_1645782888P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+OJuucC3lWbTT17ARAljJAKCA83YScmARVakwLEfaIC2aEWQEcACePJB4
aT/RbYxgmQKdfuhPTZ3Y+gM=
=BebL
-----END PGP SIGNATURE-----

--==_Exmh_1645782888P--
