Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754451AbWKRVpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbWKRVpN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbWKRVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:45:12 -0500
Received: from nsm.pl ([195.34.211.229]:15551 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1754451AbWKRVpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:45:10 -0500
Date: Sat, 18 Nov 2006 22:44:50 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: boot from efi on x86_64
Message-ID: <20061118214450.GA14048@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200611182107.03667.spatz@psybear.com> <20061118204013.GA13645@irc.pl> <20061118210957.GA5117@hockin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20061118210957.GA5117@hockin.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2006 at 01:09:57PM -0800, thockin@hockin.org wrote:
> On Sat, Nov 18, 2006 at 09:40:13PM +0100, Tomasz Torcz wrote:
> > On Sat, Nov 18, 2006 at 09:07:03PM +0200, Dror Levin wrote:
> > > looking at the kernel source, after constant failures to boot linux o=
n a core=20
> > > 2 imac, has made me understand that only i386 and ia64 support efi bo=
oting,=20
> > > but x86_64 does not.
> > > it makes sense, if you think about it... AFAIK, until the new core 2 =
imacs=20
> > > were out there was no x86_64 efi pc, so why should the kernel support=
 it?
> >=20
> >   Few days ago I played with Intel servers with EM64T Xeons (NetBurst
> > based). They are x86_64, and motherboard (Intel chipset) utilised EFI.
>=20
> but did it use GRUB or elilo ?

 Both GRUB (Ubuntu 6.10/FC5/FC6) and standard LILO (Slackware 11). I
guess BIOS compatability was turned on.

--=20
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFX37S10UJr+75NrkRAhjmAJ0X1dcLq1DCApgk3p6QmEZP1bPDqwCfVObV
rCOs3ulMIRTPaIdc6VS6/Nc=
=tICG
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
