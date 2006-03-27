Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWC0ViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWC0ViD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWC0ViC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:38:02 -0500
Received: from nsm.pl ([195.34.211.229]:3595 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751464AbWC0ViB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:38:01 -0500
Date: Mon, 27 Mar 2006 23:37:48 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: john stultz <johnstul@us.ibm.com>
Cc: Jonathan Black <vampjon@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: uptime increases during suspend
Message-ID: <20060327213748.GD4853@irc.pl>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Jonathan Black <vampjon@gmail.com>, linux-kernel@vger.kernel.org
References: <20060325150238.GA9023@beacon.dhs.org> <1143484821.2168.16.camel@leatherman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <1143484821.2168.16.camel@leatherman>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2006 at 10:40:20AM -0800, john stultz wrote:
> > Would it be possible to get the old behaviour back?
>=20
> Why exactly do you want this behavior? Maybe a better explanation would
> help stir this discussion.

  Well, if X session with xscreesaver was active when suspending,
screensacer will be activated just after resume.  And if by chance
OpenGL hack will be run, X will freeze.  Because running apps using
OpenGL or xvideo after resume freezes X (for me, at least).

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEKFssThhlKowQALQRAquQAJ9i9rIVhQaJmxfI/ZjYeKcpSxCSvQCg0UyS
pXU+G7dV94qKQ0bMMd1gRq8=
=mtls
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
