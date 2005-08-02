Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVHBJIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVHBJIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVHBJIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:08:18 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57860 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261434AbVHBJIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:08:17 -0400
Date: Tue, 2 Aug 2005 11:08:12 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050802090812.GA6724@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <1122846092.13000.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <1122846092.13000.4.camel@mindpipe>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 31, 2005 at 05:41:31PM -0400, Lee Revell wrote:
> On Sun, 2005-07-31 at 23:10 +0200, Pavel Machek wrote:
> > [But we
> > probably want to enable ACPI and cpufreq by default, because that
> > matches what 99% of users will use.]
>=20
> Sorry, this is just ridiculous.  You're saying 99% of Linux
> installations are laptops?  Bullshit.

 I'm not a laptop user, yet I'm using cpufreq on my Sempron 2500+.
cpufreq-nforce2 switching between 1,23 and 1,75 GHz makes 8-10 Celsius'
degrees difference on CPU temperature.

--=20
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other.


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFC7zf8ThhlKowQALQRAg4bAJ9QRVbmor4jtVlBKXER1pxoxQaI+gCcCR3L
02Aq6YWnZj8SZj9sfwVuh80=
=VgkL
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
