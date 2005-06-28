Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVF1UyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVF1UyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVF1UvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:51:03 -0400
Received: from nysv.org ([213.157.66.145]:11219 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261270AbVF1Ur1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:47:27 -0400
Date: Tue, 28 Jun 2005 23:47:09 +0300
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050628204709.GH11013@nysv.org>
References: <20050627092138.GD11013@nysv.org> <200506281344.j5SDixiH003441@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEfZqDS1MPR2ysog"
Content-Disposition: inline
In-Reply-To: <200506281344.j5SDixiH003441@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DEfZqDS1MPR2ysog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2005 at 09:44:59AM -0400, Horst von Brand wrote:
>
>No. But just relying on perfect hardware and concientious sysadmins is
>reckless. Hardware /is/ flaky, sysadmins /are/ (sometimes) lazy (and
>besides, today they are increasingly just plain Joe Sixpack users). Also,
>backing up a few hundred GiB is /not/ fun, and then keeping track of all
>the backups is messy.

Even home users have started to set up raid mirrors at home now that
disk space is cheap. That's a step in the right direction, I
suppose, with hardware never being good.

Taking backups in an environment where you need a few hundred GiB
backed up is not that difficult.

Get a separate, redundant box with a big tape changer and drop
periodical backups off at your bank's vault.

Get a separate, very reduntant box, with a truckload of proven=20
drives in a separate raid box and run your stuff there.

Get both of the above.

If Joe Sixpack loses his mp3 collection, I don't really care,
nor should anyone else. Anything important enough to care
about is easy enough to back up. Always.

Arrogance? Maybe.

>Also, I'm not claiming that they are /solely/ responsible, but not having
>the filesystem fall apart utterly every time some bug breaths on it /is/ a
>requirement.

Reiserfs does not fall apart utterly every time some bug breaths on it.

>> *still trying to understand how that can be*
>You haven't been around too much yet, do you?

Rather I take backups, buy better hardware and understand there's a
risk involved.

Computers as a complete set can't be trusted, you can only make
the best accomodations you can.

--=20
mjt


--DEfZqDS1MPR2ysog
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCwbdNIqNMpVm8OhwRAg7yAJsHTe6asb4HRSNSAUFIXinO1MmU+ACfaHiT
HARynNEimEs+CwJrIgjX7SM=
=pYYj
-----END PGP SIGNATURE-----

--DEfZqDS1MPR2ysog--
