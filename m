Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTJJRkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbTJJRkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:40:33 -0400
Received: from ns.schottelius.org ([213.146.113.242]:20096 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S263084AbTJJRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:40:26 -0400
Date: Fri, 10 Oct 2003 19:37:30 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Memory Issues (2.6 and later)
Message-ID: <20031010173730.GA556@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
References: <20031009181617.GB7591@schottelius.org> <Pine.LNX.4.44.0310101055190.18387-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310101055190.18387-100000@chimarrao.boston.redhat.com>
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rik van Riel [Fri, Oct 10, 2003 at 10:55:54AM -0400]:
> On Thu, 9 Oct 2003, Nico Schottelius wrote:
>=20
> > Any ideas where the problem is?
>=20
> No. It would help if you showed us some output from 'vmstat 5'
> near when the system runs out of memory, and maybe an overview
> of how much memory you have and how much is taken by programs.

flapp:~ # vmstat 5
-bash: vmstat: command not found

what package is that, where can I get it?

I would like to help to debug it, but I need some help from other
kernel developers, as I don't write much kernel code.

Have a nice day,

Nico

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hu5ZzGnTqo0OJ6QRAhdvAKDMe++sxcGsgIxiTx/OJxdMl2EwkQCbB4EL
B7dMrnmG8UmncJNORqfVLMY=
=dXUU
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
