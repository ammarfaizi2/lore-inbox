Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbTJIVrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTJIVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:47:41 -0400
Received: from ns.schottelius.org ([213.146.113.242]:1408 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S262596AbTJIVrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:47:39 -0400
Date: Thu, 9 Oct 2003 20:16:17 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: Kernel Memory Issues (2.6 and later)
Message-ID: <20031009181617.GB7591@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test6
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Once again I have to report: Linux 2.6 seems to have problems managing
memory.
After working on a laptop system (with Mozilla, X 4.3.99, Opera, 4xterms)
for some hours the system becomes very slow.
It looks like the system has no memery left, partly programs get
killed (Out of Memory) although there is plenty memory left.

I tried to kill processes to see whether one processes has a memory leak,
but that's not the case.

I even tried to kill all processes and restart everything (with sysrg+k)
but this didn't show any success.

Any ideas where the problem is?

Nico

ps: please CC me again, not subscribed.

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/haXxzGnTqo0OJ6QRAm+FAKDgT0GShxau3XRysV+I7u6gqf/gggCg1rWw
jxMjG9XgBoU7Z94LVkACLCw=
=hM11
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
