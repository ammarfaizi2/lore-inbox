Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSACOHL>; Thu, 3 Jan 2002 09:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287292AbSACOHB>; Thu, 3 Jan 2002 09:07:01 -0500
Received: from mail.gmx.de ([213.165.64.20]:32189 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287291AbSACOGq>;
	Thu, 3 Jan 2002 09:06:46 -0500
Date: Thu, 3 Jan 2002 15:09:22 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-dj11
Message-Id: <20020103150922.401d0f1d.sebastian.droege@gmx.de>
In-Reply-To: <20020103030603.A26386@suse.de>
In-Reply-To: <20020103030603.A26386@suse.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.MRdQOix6G1:Nr'"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.MRdQOix6G1:Nr'
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
While compiling 2.5.1-dj11 I get the following error in sr.c:

sr.c: In function `sr_release':
sr.c:102: invalid operands to binary &
sr.c:103: invalid operands to binary &
sr.c:104: invalid operands to binary &
sr.c:105: invalid operands to binary &
sr.c:106: invalid operands to binary &
sr.c:106: invalid operands to binary &
sr.c:106: warning: value computed is not used
sr.c: In function `sr_media_change':
sr.c:153: invalid operands to binary &
sr.c:162: invalid operands to binary &
sr.c:167: invalid operands to binary &
sr.c:168: invalid operands to binary &
sr.c:182: invalid operands to binary &
sr.c:184: invalid operands to binary &
sr.c: In function `sr_find_queue':
sr.c:256: invalid operands to binary &
sr.c:256: invalid operands to binary &
sr.c:259: invalid operands to binary &
sr.c: In function `sr_init_command':
sr.c:266: invalid operands to binary &
sr.c: In function `sr_open':
sr.c:402: invalid operands to binary &
sr.c:403: invalid operands to binary &
sr.c:410: invalid operands to binary &
sr.c:413: invalid operands to binary &
sr.c:414: invalid operands to binary &
sr.c:415: invalid operands to binary &
sr.c:415: invalid operands to binary &
sr.c:415: warning: value computed is not used
sr.c:424: invalid operands to binary &
sr.c:425: invalid operands to binary &
sr.c: In function `sr_packet':
sr.c:674: invalid operands to binary &
sr.c:680: invalid operands to binary &
sr.c: In function `sr_finish':
sr.c:769: incompatible types in assignment
sr.c: In function `sr_detach':
sr.c:812: incompatible type for argument 1 of `invalidate_device'
make[3]: *** [sr.o] Fehler 1

I don't know wether this error was reported already or if it is in 2.5.2-pre6... But I'll test it ;)

Bye
--=.MRdQOix6G1:Nr'
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8NGYUvIHrJes3kVIRArJQAJ9jOwH+bl/SC7r9F+qm+r91ERJb+gCfRwMM
dpVEWx8NDQVd7rmn2fa0FF8=
=1PkG
-----END PGP SIGNATURE-----

--=.MRdQOix6G1:Nr'--

