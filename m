Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVLXLwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVLXLwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 06:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVLXLwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 06:52:04 -0500
Received: from killerfox.home.forkbomb.ch ([213.144.146.167]:63974 "EHLO
	killerfox.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932106AbVLXLwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 06:52:02 -0500
Date: Sat, 24 Dec 2005 12:52:20 +0100
From: =?utf-8?B?UmVuw6k=?= Nussbaumer 
	<linux-kernel@killerfox.forkbomb.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
       Stelian Pop <stelian@popies.net>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051224115219.GA5993@killerfox.forkbomb.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch> <20051130234653.GB15102@hansmi.ch> <1133533712.23129.25.camel@localhost.localdomain> <20051204224221.GA28218@hansmi.ch> <1135382385.4542.8.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1135382385.4542.8.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

On Sat, Dec 24, 2005 at 10:59:44AM +1100, Benjamin Herrenschmidt wrote:
[...]
> comes with KDE for it but couldn't "boost" it to anything useful. Is
> that expected or is there still issues to be resolved in the driver ?
> I'm tempted to add some minimum support for a proper acceleration curve
> in the kernel driver in fact...

I'd the same problem. A quick look into Xorg.0.log tells me, that the
event device was missing. I created it manually and the acceleration and
other feautres are working now. Maybe you've still the same problem?

Ren=C3=A9
--=20
Written on a Gentoo Linux-system by Ren=C3=A9
http://www.forkbomb.ch
=C2=ABDas Leben ist hart. Forkbomb ist h=C3=A4rter.=C2=BB, (c) 2004 by Fran=
k.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDrTZzB1CkVTVL/Z8RAq9wAKCgLDX83nhvxg1zbo+jvsB0t+RmaQCgwKOa
aHx60ukovJfD5Sa8vLkjUmU=
=x1IE
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
