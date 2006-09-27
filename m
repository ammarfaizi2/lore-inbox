Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965490AbWI0KAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965490AbWI0KAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 06:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965492AbWI0KAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 06:00:36 -0400
Received: from systemlinux.org ([83.151.29.59]:43484 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S965490AbWI0KAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 06:00:35 -0400
Date: Wed, 27 Sep 2006 11:58:39 +0200
From: Andre Noll <maan@systemlinux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andy Whitcroft <apw@shadowen.org>,
       Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
Message-ID: <20060927095839.GK20462@skl-net.de>
References: <45185A93.7020105@google.com> <4518DC0B.10207@shadowen.org> <4518E4DF.8010007@goop.org> <m1venaqeg6.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline
In-Reply-To: <m1venaqeg6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19:35, Eric W. Biederman wrote:
> I have seen this one as well,

Me too. Current linus git tree, x86_64 SMP, gcc-3.3.5, GNU ld version 2.15,=
 binutils
2.15-6, Debian.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFGktPWto1QDEAkw8RAhw0AKCnsoxzDiVroB4xM0zFkAXdQmLOOwCfbPJU
iJf5+Rih4c56RoK1flKxy8Q=
=dcNk
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
