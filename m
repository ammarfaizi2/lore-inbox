Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVBTN0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVBTN0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 08:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVBTN0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 08:26:07 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:32441 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261827AbVBTN0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 08:26:01 -0500
Date: Sun, 20 Feb 2005 14:26:00 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050220132600.GA19700@spock.one.pl>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20050219232519.GC1372@elf.ucw.cz>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 20, 2005 at 12:25:19AM +0100, Pavel Machek wrote:

Hi,
=20
> Yes, I agree, almost anything is more sane than code I posted :-(. My
> only requirement is that it works with radeonfb and similar low-level
> drivers (so that I can get suspend-to-ram to work) and that it gets
> past our branding people...  =20

I don't know about the branding people, but suspend-to-ram and radeonfb
shouldn't be a problem for fbsplash :)
=20
> How many distros do use some variant of bootsplash? SuSE does, from
> above url I guess gentoo does, too... Does RedHat do something
> similar? [Or do they just set log-level to very high giving them clean
> look?] What about Debian?

As far as I know: SuSE uses bootsplash, Gentoo and PLD use fbsplash,
RedHat uses rhgb (100% userspace solution, based on xvesa, doesn't
provide graphical backgrounds on vt's - for that a kernel patch like
bootsplash or fbsplash is necessary). I don't know about Debian - they
probably have some (possibly unofficial) support for both bootsplash
and fbsplash.

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCGI/oaQ0HSaOUe+YRAnvYAJ9XBzuBEjqRA9aKstcgGmzmYrCfTwCgoP8x
JcNUDt076KcuBHX3rLnD76A=
=j6Po
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
