Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpA4nopDsXRLdQyagIJvyY7h+MA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 03:48:20 +0000
Message-ID: <00a101c415a4$0e27dd90$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:42 +0100
X-Mailer: Microsoft CDO for Exchange 2000
From: "Paul Mundt" <lethal@linux-sh.org>
To: <Administrator@osdl.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0-rc1 - Watchdog patches
Content-Class: urn:content-classes:message
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,Wim Van Sebroeck <wim@iguana.be>, Linus Torvalds <torvalds@osdl.org>,Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
References: <20040103002459.K30061@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20040103002459.K30061@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:42.0984 (UTC) FILETIME=[0E2C9880:01C415A4]

This is a multi-part message in MIME format.

--xHFwDpU9dbj6ez1V
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wim,

On Sat, Jan 03, 2004 at 12:24:59AM +0100, Wim Van Sebroeck wrote:
>  drivers/char/watchdog/shwdt.c        |   14 +-
>=20
This change is useless, it's just whitespace modification. Perhaps you may =
want
to be more careful with diff in the future so you don't constantly generate
superfluous changes. There definitely seems to be a lot of whitespace chang=
es
throughout the rest of these patches as well..


--xHFwDpU9dbj6ez1V
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/9jrl1K+teJFxZ9wRAgozAJ45JuaqEBwpXqk/uBOvNK1t4Sr+KwCfSJWH
I7c006Ll4UJkAFFxy2IfH7Q=
=gDL9
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
