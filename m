Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132900AbRDEO1s>; Thu, 5 Apr 2001 10:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132910AbRDEO1i>; Thu, 5 Apr 2001 10:27:38 -0400
Received: from 63-224-228-227.customers.uswest.net ([63.224.228.227]:48992
	"HELO galen.magenet.net") by vger.kernel.org with SMTP
	id <S132900AbRDEO1X>; Thu, 5 Apr 2001 10:27:23 -0400
Date: Thu, 5 Apr 2001 07:26:28 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Bart Trojanowski <bart@jukie.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
Message-ID: <20010405072628.C22001@debian.org>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER> <Pine.LNX.4.30.0104050901500.13496-100000@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0104050901500.13496-100000@localhost>; from bart@jukie.net on Thu, Apr 05, 2001 at 09:06:20AM -0400
X-Operating-System: Linux galen 2.4.2-ac26
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2001 at 09:06:20AM -0400, Bart Trojanowski wrote:
> So you ask: "why not just use a { ... } to define a macro".  I don't
> remember the case for this but I know it's there.  It has to do with a
> complicated if/else structure where a simple {} breaks.

This doesn't follow in my mind.  I can't think of a case where a { ... }
would fail, but a do { ... } while (0) would succeed.  The former would
also save a few keystrokes.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

// Minor lesson: don't fuck about with something you don't fully understand
        -- the dosdoom source code


--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEUEARECAAYFAjrMgJQACgkQj/fXo9z52rPVEwCeNuBAmuumhQzUDLYP7eOX3rAr
JHQAlAsHj/boCX4E9QIwk+wRaGGHc2M=
=L0jM
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
