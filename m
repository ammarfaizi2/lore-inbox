Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWAPAGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWAPAGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 19:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWAPAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 19:06:40 -0500
Received: from melchior.nerv-un.net ([216.179.125.34]:28682 "EHLO nerv-un.net")
	by vger.kernel.org with ESMTP id S932082AbWAPAGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 19:06:39 -0500
Date: Sun, 15 Jan 2006 19:06:39 -0500
From: Mike Kershaw <dragorn@kismetwireless.net>
To: Sam Leffler <sam@errno.com>
Cc: Stefan Rompf <stefan@loplof.de>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116000639.GC20344@DRD1812>
Reply-To: Mike Kershaw <dragorn@kismetwireless.net>
References: <20060113195723.GB16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <200601151340.10730.stefan@loplof.de> <43CAA4FD.5070605@errno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <43CAA4FD.5070605@errno.com>
Organization: Kismet Wireless
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2006 at 11:39:41AM -0800, Sam Leffler wrote:
> The big stumbling block I found to going with virtual devices is that it=
=20
> affects user apps.  I looked at doing things like auto-create a station=
=20
> device for backwards compatibility but decided against it.  If you=20
> really want this behaviour it can be done by user code.

Right, no reason not to just put this into a hotplug script, is there?
Is it, when it comes down to it, significantly different than automating
firmware loads for the user?

-m

--=20
Mike Kershaw/Dragorn <dragorn@kismetwireless.net>
GPG Fingerprint: 3546 89DF 3C9D ED80 3381  A661 D7B2 8822 738B BDB1

Experts in ancient Greek culture say that people back then didn't see their
thoughts as belonging to them.  When they had a thought, it occured to them
as a god or goddess giving them an order.  Apollo was telling them to be
brave.  Athena was telling them to fall in love.
Now people hear a commercial for sour cream potato chips and rush out to bu=
y.
	-- Chuck Palahniuk

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDyuOP17KIInOLvbERAoZTAJ9mTn+dwdKWkSufaEHWBXwJnc3BFwCg5YUi
bNUZknbLHgUHOVZn4ZtDfCA=
=MEGa
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
