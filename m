Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRDQWoe>; Tue, 17 Apr 2001 18:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132853AbRDQWoZ>; Tue, 17 Apr 2001 18:44:25 -0400
Received: from linas.org ([207.170.121.1]:44279 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S132710AbRDQWoN>;
	Tue, 17 Apr 2001 18:44:13 -0400
Date: Tue, 17 Apr 2001 17:44:07 -0500
To: Gunther.Mayer@t-online.de
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: resending-- Re: mouse problems in 2.4.2 -> lost byte -> Patch(2.4.3)!]
Message-ID: <20010417174407.L6403@backlot.linas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: linas@backlot.linas.org (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

resending another lost message

----- Forwarded message from Linas Vepstas <linas@linas.org>, linas@linas.o=
rg -----

Subject: Re: mouse problems in 2.4.2 -> lost byte -> Patch(2.4.3)!
In-Reply-To: <3AD0C8AD.1A4D7D12@t-online.de> "from Gunther Mayer at Apr 8, =
2001
	10:23:09 pm"
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Date: Mon, 9 Apr 2001 18:42:51 -0500 (CDT)
From: Linas Vepstas <linas@linas.org>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,=20
	Vojtech Pavlik <vojtech@suse.cz>, linas@linas.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]

It's been rumoured that Gunther Mayer said:
> Losing bytes on psaux is a bug!
 [...]
> This patch printk's necessary information on the first 2 cases and

I had applied a similar set of printk's several weeks ago; however,=20
now the problem refuses to recur.  Hmmm ... the last time I had a
problem that went away when I added printf's  ...

Just to be sure, I'm going to try running the kernel without the
printk's again.   Unfortunately, I upgraded the xserver yesterday,
and so I fear that may mask further re-occurances ...

--linas


----- End forwarded message -----

--=20
Linas Vepstas   -- linas@linas.org -- http://linas.org/

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63Mc1ZKmaggEEWTMRAg3hAJ9kzPpwUii5OzFRFI0AdOOUHSODDgCfT7Qa
vRf4HJpD8EhTPL3Gc71yAWo=
=TBiH
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
