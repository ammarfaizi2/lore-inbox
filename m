Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133006AbRA2K4V>; Mon, 29 Jan 2001 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135826AbRA2K4M>; Mon, 29 Jan 2001 05:56:12 -0500
Received: from office.globe.cz ([212.27.204.26]:53255 "HELO gw.office.globe.cz")
	by vger.kernel.org with SMTP id <S133006AbRA2Kz7>;
	Mon, 29 Jan 2001 05:55:59 -0500
Received: from ondrej.office.globe.cz (10.1.2.22)
  by vger.kernel.org with SMTP; 29 Jan 2001 10:55:51 -0000
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com>
	<E14NB8r-000063-00@roos.tartu-labor>
	<20010129032637.A642@ogah.cgma1.ab.wave.home.com>
From: Ondrej Sury <ondrej@globe.cz>
Date: 29 Jan 2001 11:55:44 +0100
In-Reply-To: <20010129032637.A642@ogah.cgma1.ab.wave.home.com>
Message-ID: <87g0i2lj9r.fsf@ondrej.office.globe.cz>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Harold Oga <ogah@home.com> writes:

> Hi,
>    I'm seeing similar problems with my system on 2.4.1-pre10.  This is an
> AMD Thunderbird 900, MSI K7T Pro2-A mobo w/VIA KT133 chipset, UP, ide/scsi
> mix.  2.4.1-pre10 works fine if I don't configure ACPI.  I'll try to
> narrow down when this problem started showing up later today, as I
> initially moved from 2.4.1-pre3 straight to 2.4.1-pre10.

It's something between pre9 and pre10, and probably it's VIA chipset
problem.

=2D-=20
Ond=F8ej Sur=FD <ondrej@globe.cz>         Globe Internet s.r.o. http://glob=
e.cz/
Tel: +420235365000   Fax: +420235365009         Pl=E1ni=E8kova 1, 162 00 Pr=
aha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iEYEARECAAYFAjp1TDUACgkQ9OZqfMIN8nPFVgCgqZVuKxkOFQ854bGH3AkiCovZ
lSQAn1jOppC9aV41/NwWtENwDNEKTLGQ
=V3QD
-----END PGP MESSAGE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
