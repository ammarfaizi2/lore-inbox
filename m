Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280624AbRKJMV6>; Sat, 10 Nov 2001 07:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280623AbRKJMVu>; Sat, 10 Nov 2001 07:21:50 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:55211 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S280620AbRKJMVk>; Sat, 10 Nov 2001 07:21:40 -0500
Date: Sat, 10 Nov 2001 13:21:39 +0100
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
Message-ID: <20011110132139.A872@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.15-pre2
X-Telephone: +32 486 460306
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

J Sloan (jjs@pobox.com) wrote:
> I have been running the 2.4.15-pre kernels and
> have found an interesting oops. I can reproduce
> it immediately, and reliably, just by issuing an ssh
> command (as a normal user).

I'm currently running Linux 2.4.15-pre2 and have no troubles with ssh. I can
safely login onto other hosts, or issuing commands like
	ssh -l someuser@somehost mutt
or copy files
	scp somefile someuser@somehost:

I'm not using OpenSSH 3.0 yet (2.9p2). I'm not running any firewall or
transparent proxying.

PS My apologies that this reply isn't like it should be (no Message-ID to
   what it is replying) but I've removed the mail before I could reply...

--=20
Taking advice on what the GPL means from Microsoft is like taking
Stalin's word on the meaning of the US Constitution. ~(Eben Moglen)

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE77RvTXfqz7M26L9sRAhwKAJ4qad0rPVYdhkLLo86pEmoW7rE9tACgkYAQ
QJnyO+PXh6cOPcfnlp9ZnGk=
=8pQb
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
