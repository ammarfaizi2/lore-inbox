Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275963AbRJUMDH>; Sun, 21 Oct 2001 08:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275968AbRJUMC5>; Sun, 21 Oct 2001 08:02:57 -0400
Received: from stingr.net ([212.193.33.37]:5903 "HELO stingray.sgu.ru")
	by vger.kernel.org with SMTP id <S275963AbRJUMCo>;
	Sun, 21 Oct 2001 08:02:44 -0400
Date: Sun, 21 Oct 2001 16:03:12 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: AIC7XXX-EISA hang at boot
Message-ID: <20011021160312.D39722@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-RealName: Stingray Greatest Jr
Organization: Stingray Software
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

I've got stuck in the problem

I trying to work with another piece of very old hardware. Acer altos 7000 or
something - p-75, with eisa bus and onboard eisa aic7xxx

it works with 2.4.7ac5
but for performance reasons I want to upgrade to something newer, for
example 2.4.12ac3
or 2.4.10ac4

doesn't matter
It hangs just after printk "SCSI subsystem ..." etc
with working kernel after that line we have scsi hardware driver init

so - do anybody know what's wrong with aic7xxx and who broke it after
2.4.7ac5 so it can't work on hardware described here ?

thanks

- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAjvSuXkACgkQyMW8naS07KTanACfQ8KZlJlC7QfvMVoLuv41Pm5M
zucAn10LrGnXACgqkswYaFdXZkqXeMV5
=VRji
-----END PGP SIGNATURE-----
