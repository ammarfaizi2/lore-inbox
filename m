Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUBDM1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 07:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUBDM1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 07:27:40 -0500
Received: from coruscant.franken.de ([193.174.159.226]:51377 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S262838AbUBDM1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 07:27:38 -0500
Date: Wed, 4 Feb 2004 13:25:50 +0100
From: Harald Welte <laforge@netfilter.org>
To: Dan McGrath <troubled@emaildesktop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iptables stopped logging to files, but shows in ring buffer
Message-ID: <20040204122550.GE25175@obroa-skai.de.gnumonks.org>
References: <001801c3ead5$9d0d6420$0201a8c0@wksdan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZQ/M1iA+qg8otEW"
Content-Disposition: inline
In-Reply-To: <001801c3ead5$9d0d6420$0201a8c0@wksdan>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.1-rc1-ben1
X-Date: Today is Prickle-Prickle, the 34th day of Chaos in the YOLD 3170
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZQ/M1iA+qg8otEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2004 at 11:16:07PM -0500, Dan McGrath wrote:
> I remembered that iptables logs seem to show in dmesg command in the
> past, and sure enough, they are all showing up there no problems, but not=
 in
> any files, including dmesg.log.

If they are in dmesg, but in no files, than this cannot be a kernel
problem.  It has to be a userspace (klogd/syslogd) issue.

Thus, it is off-topic to lkml, and is not a problem of
netfilter/iptables.

> troubled

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--4ZQ/M1iA+qg8otEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAIOTOXaXGVTD0i/8RAnOHAJ9hbocWmW1txsL2MlShpsZ8zG/VFwCgjb8e
l+fg3in9LZDO9oSj6euEY+k=
=p0v8
-----END PGP SIGNATURE-----

--4ZQ/M1iA+qg8otEW--
