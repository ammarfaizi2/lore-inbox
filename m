Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTJIVrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTJIVrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:47:45 -0400
Received: from ns.schottelius.org ([213.146.113.242]:1664 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S262600AbTJIVrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:47:39 -0400
Date: Thu, 9 Oct 2003 19:27:10 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: keyboard rate changed in 2.6.0test5/6 - why / how?
Message-ID: <20031009172710.GA7591@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test6
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

There is a difference (subjective) feeling between 2.6.0test4 kernels
and 2.6.0test6 kernels:

When I press one key and wait how fast it repeats printing it differs
between those kernels.

test4:
   very fast, very smooth. I like that. it's like it latter 2.5 series

test6:
   more or less fast; like in 2.4 series.

Can you tell me what you changed and howto regain this smooth handling from
test4?

I don't think kbdrate will be the right tools, as the difference was seen/
recognizable on console and under X.

Have a nice day,

Nico

ps: please CC me, I am not subscribed to the lkml.

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hZpuzGnTqo0OJ6QRArxmAJ0SQBRhjwE9+1X885gZhaFe0pdPNACfVEXb
onnwyz1N679za1TbwRzB968=
=WSzP
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
