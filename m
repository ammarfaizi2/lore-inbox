Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRLQRV4>; Mon, 17 Dec 2001 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281678AbRLQRVq>; Mon, 17 Dec 2001 12:21:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:20490 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281663AbRLQRVc>;
	Mon, 17 Dec 2001 12:21:32 -0500
Date: Mon, 17 Dec 2001 18:23:43 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-Id: <20011217182343.7aea2048.sebastian.droege@gmx.de>
In-Reply-To: <Pine.LNX.4.33.0112171755060.28670-100000@Appserv.suse.de>
In-Reply-To: <20011217175206.193d02e0.sebastian.droege@gmx.de>
	<Pine.LNX.4.33.0112171755060.28670-100000@Appserv.suse.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.QmtTog?6kiEPJ9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.QmtTog?6kiEPJ9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Thanks
This does work
What do you think was exactly the problem?

Bye

On Mon, 17 Dec 2001 17:57:01 +0100 (CET)
Dave Jones <davej@suse.de> wrote:

> On Mon, 17 Dec 2001, Sebastian Dröge wrote:
> 
> > 2.4.16-2.4.17-rc1 works perfectly
> > 2.5.0-2.5.1 works perfectly
> > Only 2.5.1-dj1 has this 2 errors (ISA-PnP non-detection and USB only root hub detection)
> > All have the same .config
> > If you need some more information feel free to ask me ;)
> 
> Ok, can you try backing out this patch.. (just patch as normal but with -R)
> http://www.codemonkey.org.uk/patches/2.5/small-bits/early-cpuinit-1.diff
> 
> regards,
> Dave.
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 

--=.QmtTog?6kiEPJ9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8HiohvIHrJes3kVIRAtPVAKCscabhKjpmPSyZccFYDwvr3rSmhgCgpNfu
nLzkwv2BjBvxQL43xOFwVsk=
=jWZX
-----END PGP SIGNATURE-----

--=.QmtTog?6kiEPJ9--

