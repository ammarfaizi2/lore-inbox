Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVDFCtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVDFCtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVDFCtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:49:41 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:1970 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262083AbVDFCth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:49:37 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Date: Tue, 5 Apr 2005 22:49:29 -0400
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
References: <20050405185620.80060.qmail@web88009.mail.re2.yahoo.com> <20050405204234.GE1380@elf.ucw.cz>
In-Reply-To: <20050405204234.GE1380@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1190047.sdQ0FRJkRK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504052249.35030.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1190047.sdQ0FRJkRK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So nobody minds if I make this into a CONFIG option marked as Deprecated? :)

Shawn.

>
> > Do you know if /proc/acpi/sleep will be deprecated in
> > favour of /sys/power/state? If so, this thread will be
> > moot ;)
>
> No idea, deprecating it would be ok with me.
>
>        Pavel

--nextPart1190047.sdQ0FRJkRK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCU04+sX/SQXZigqcRAm3wAJ0Z3ZdArjH3rrQafruoZNtXpIDVoACeO+sN
jEWXEPU1302+/Vee/4S6i7w=
=/6l8
-----END PGP SIGNATURE-----

--nextPart1190047.sdQ0FRJkRK--
