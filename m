Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWCISka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWCISka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWCISka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 13:40:30 -0500
Received: from nsm.pl ([195.34.211.229]:28433 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751299AbWCISk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 13:40:29 -0500
Date: Thu, 9 Mar 2006 19:40:11 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060309184010.GA4639@irc.pl>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
	akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz,
	pcihpd-discuss@lists.sourceforge.net
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de> <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org> <20060308231851.GA26666@suse.de> <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2006 at 03:30:22PM -0800, Linus Torvalds wrote:
>=20
>=20
> On Wed, 8 Mar 2006, Greg KH wrote:
> >=20
> > Understood.  Wait, what FC5 issues?  Andrew's problems?  Or something
> > else?
>=20
> Something else.
>=20
> Although it might be related, since DaveJ reports that there are some=20
> weird bootup issues that come and go:
>=20
>   "Fedora rawhide kernel stopped booting for a bunch of people, all with=
=20
>    686-SMP boxes. I saw it myself too, it hung just after the 'write=20
>    protecting kernel rodata'.
>=20

  Ubuntu has similar problem:
https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/29601
 I believe Ubuntu's 2.6.15 source is vanilla+git patches.

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEEHaKThhlKowQALQRAmr6AKCeBLUl3frsYS0KocQuM3zJbmyr6QCg95pJ
MmBrAoezjBM07DXQUMKHNI8=
=/8PF
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
