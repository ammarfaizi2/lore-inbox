Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVARA6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVARA6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVARA6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:58:32 -0500
Received: from remus.commandcorp.com ([130.205.32.4]:55768 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S261374AbVARA6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:58:24 -0500
Date: Mon, 17 Jan 2005 20:56:04 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove obsolete Computone MAINTAINERS entry (fwd)
Message-ID: <20050118015604.GB31238@alcove.wittsend.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041120002559.GB2754@stusta.de> <20041119194735.63d2a257.akpm@osdl.org> <20041220191530.GA25986@alcove.wittsend.com> <20050101172832.GB14319@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <20050101172832.GB14319@stusta.de>
User-Agent: Mutt/1.4i
X-Alcove.WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-Alcove.WittsEnd-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 01, 2005 at 06:28:32PM +0100, Adrian Bunk wrote:

> At least the mailing list is definitely dead:

	The mailing list use to be run by Louis Zamora who use to work for
Computone.  Guess I need to deal with that and move it to some of my
own hardware.  I hadn't realized it was out of commission.

> <linux-computone@lazuli.wittsend.com>:
> Sorry, I wasn't able to establish an SMTP connection. (#4.4.1)
> I'm not going to try again; this message has been in the queue too long.

> > 	I've got two patches in my queue for the Computone drivers for
> > 2.6 plus three patches that apply to both the 2.4 and 2.6 kernels.  I've
> > got to check to see if Marcelo got around to integrating those patches
> > into 2.4 and then jump onto the combined patches.

> > 	As Shrek said...  (You didn't slay the dragon?) - "It's on my
> > todo list".

> It seems you are still active :-) , so why is it "Orphaned"?

	Good question.  Probably someone jumping the gun a bit because
I haven't been very active on that driver lately.  I do tend to drop
off the radar for months at a time, depending on other projects and
engagements.  I haven't done updates to the driver in the 2.6 kernel
and, yes, it is broken.

	Marcelo integrated my 2.4 patches and I've got testers running
that code now.  I've got a 2.6 patch that integrates those fixes and
fixes some 2.6 problems.  In the course of working on the 2.6 patch
I stumbled onto another problem that had to be retrofitted back into
the 2.4 patch which, fortunately, made it into the patch I gave to
Marcelo.  I'm looking over a couple of other changes that went in with
that 2.4 update.  I'll try and get a patch out in a couple of days
against 2.6.10.

> > 	Mike

> cu
> Adrian

> --=20

>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed

--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iQCVAwUBQexstOHJS0bfHdRxAQEkrQP+IYKA+UJ9s5YnYO0zZ5acNIN1Vct88iw3
XGb054Dz5qQKpTqWd/Z2GWcQmevX/3skvsDItCtPJf2/nuM8hdXJgssKxmnQEeGx
a20kxlKTyDJrNhxmgHahYHCxvU5N30WDemfFtBoy4vqa//it9dg+XO9FgoKJVMol
rrDjqHwEBmM=
=wEmf
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
