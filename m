Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWHILx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWHILx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWHILx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:53:59 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:39913 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161003AbWHILx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:53:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 21:54:15 +1000
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15404602.IkaQGrMOvA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608092154.16559.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart15404602.IkaQGrMOvA
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Steven.

Have you tried building the ACPI modules as modules (if you're not already=
=20
doing so), and unloading them while suspending? If not, I'd give that a go.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart15404602.IkaQGrMOvA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2czoN0y+n1M3mo0RAoQUAJ4oukCig28y/Xik3Aq0qEN8JRJegQCaA0Rn
7yQxA8rMaC8VcCHuQZLMLSE=
=wwWK
-----END PGP SIGNATURE-----

--nextPart15404602.IkaQGrMOvA--
