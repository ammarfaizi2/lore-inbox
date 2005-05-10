Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVEJVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVEJVMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVEJVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:12:15 -0400
Received: from attila.bofh.it ([213.92.8.2]:51139 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261805AbVEJVIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:08:36 -0400
Date: Tue, 10 May 2005 23:02:59 +0200
To: Greg KH <gregkh@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510210259.GA15541@wonderland.linux.it>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	Lee Revell <rlrevell@joe-job.com>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <1115756904.14061.23.camel@mindpipe> <20050510205950.GB3634@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20050510205950.GB3634@suse.de>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 10, Greg KH <gregkh@suse.de> wrote:

> > It's quite often used by ALSA users who need to prevent hotplug from
> > loading the OSS modules.  Is there a better way to do this?
> Don't build the OSS modules at all?  :)
Not a solution, some users still need them.

--=20
ciao,
Marco

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgSGDFGfw2OHuP7ERAjQDAJ4qQVN+ZHI91PpJX/XgPazSTmLUoQCfSOJF
9ZNVTWTgdbYh7jnCLKeSl7c=
=OSBR
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
