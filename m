Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272266AbTHDWIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272268AbTHDWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:08:18 -0400
Received: from mx2.undergrid.net ([64.174.245.170]:13478 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S272266AbTHDWIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:08:11 -0400
Date: Mon, 4 Aug 2003 15:05:51 -0700
From: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
To: linux-kernel@vger.kernel.org, breed@users.sourceforge.net
Subject: Re: PROBLEM: Problem with wireless PCMCIA card insertion on 2.6.0-test2
Message-ID: <20030804220551.GA3864@UnderGrid.net>
Mail-Followup-To: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>,
	linux-kernel@vger.kernel.org, breed@users.sourceforge.net
References: <20030804171858.GA3215@UnderGrid.net> <20030804190133.D25847@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20030804190133.D25847@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	After recompiling with 2.6.0-test2-bk4 I am still unable to use
the CardBus 802.11b wireless cards (don't know about any other cardbus
device as this is currently the only device I'm using). The Orinoco Gold
will load the module and does not crash but it also does not allow it to
be fully usuable. It is unable to be configured for the ESSID and WEP
key. The Cisco Aironet 350 locks the whole system up but now with -bk4
does not produce any entries in /var/log/kern.log as I was finding
before.

	Regards,
	Jeremy

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE/Lti+VExIaGLb32IRAk3mAJ97HRi8o0nB2mGti2ZQNWZ+fyjniACfZyVP
1iHUdaJccHSS1DqoocNGUiU=
=QFP5
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
