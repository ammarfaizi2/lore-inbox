Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132144AbRDMWi1>; Fri, 13 Apr 2001 18:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRDMWiR>; Fri, 13 Apr 2001 18:38:17 -0400
Received: from toscano.org ([64.50.191.142]:29390 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S132144AbRDMWiJ>;
	Fri, 13 Apr 2001 18:38:09 -0400
Date: Fri, 13 Apr 2001 18:38:06 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac5
Message-ID: <20010413183806.A4987@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14njvB-0000xu-00@the-village.bc.nu> <20010413180947.A22533@rochester.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010413180947.A22533@rochester.rr.com>; from gnea@rochester.rr.com on Fri, Apr 13, 2001 at 06:09:47PM -0400
X-Unexpected: The Spanish Inquisition
X-Uptime: 6:34pm  up 19:20,  3 users,  load average: 0.32, 0.13, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, 13 Apr 2001, Scott Prader wrote:

> one of the problems i've been having so far with the 2.4.3 series is the
> fact that USB appears to be futzed.  It just doesn't want to work right.
> Also, I compile a lot of things as modules and I've been getting lots of
> unresolved symbols and hence many things (including my nic) don't work,
> so I am still stuck at 2.4.2-ac4.  So here's some info that should help
> out whoevers doing the specific work on USB and whatever else decided it
> wanted to say "ok, you suck, go away" ;)
[snip]
> modutils               2.4.2
[snip]

probably a silly question, but have you tried modutils 2.4.5?  these
won't help with the missing symbol issues, but are you using the latest
hotplug scripts and the patched version of pci-utils and usb-utils?
there are links to all of these at the linux-usb site.

hth,
pete

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE613/OsMikd2rK89sRAu4mAJ9NiY22RsjvhINvqiNBNaBzIfIUTgCggp4W
NBJs2Uu5UMrzCBcOfF6Xgyc=
=J9AW
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
