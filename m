Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266827AbUFYSDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUFYSDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUFYSDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:03:21 -0400
Received: from 64-60-248-69.cust.telepacific.net ([64.60.248.69]:48695 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S266828AbUFYSCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:02:34 -0400
Date: Fri, 25 Jun 2004 11:02:44 -0700
From: Joshua Kwan <jkwan@rackable.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HELP] Tracking down a MD bug
Message-ID: <20040625180244.GA8009@mx.rackable.com>
Mail-Followup-To: Joshua Kwan <jkwan@rackable.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <pan.2004.06.24.17.24.17.353731@rackable.com> <16603.19400.833911.26478@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <16603.19400.833911.26478@cse.unsw.edu.au>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040523i
X-OriginalArrivalTime: 25 Jun 2004 18:02:00.0120 (UTC) FILETIME=[830E2B80:01C45ADE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2004 at 07:46:48AM +1000, Neil Brown wrote:
> > Are there any MD code changes that could have caused this so I can point
> > SuSE somewhere? (Well, then again, many SuSE folks are on this list
> > anyway...)
>=20
> This is definitely a bug in the Suse 2.6.4-52 kernels, and I'm pretty
> sure they have fixed it.

Thanks, I upgraded the box to 2.6.5-7.75-smp and the bug has vanished.

--=20
Joshua Kwan

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQNxoxKOILr94RG8mAQJ8vg/+LhyHHn+3wZMsbQLY64gyiybdLSzB8YDr
1Qh1HikcDeeed7LoNvE7vfhaMODs9axcZFPib6JM4ABXokQUAfwq5SlWzxvSrEUT
J4v3Jb9mdoP3PDlztl/GIkoavCVe8+ri6cj2LQXgb2yaIYLneE+d0RWxxpINibnx
rlxZK2US3mRTMUG5rCp1JhaszfWa8DgRDDqsmfch9RzaGvsCX6PILfmQIxNRT47h
PFUsxnboHPzAuRm4OyV9jgdAyDzwlaGi4R/wOuZ8fiaxCNTQ+YuSGUAck237OBWz
7mubbm1bSCdRP/8UIiYS9I+9uFjfnhyp/q+yhCf4THy2T0K1XgGyWvQ64h29CxIu
/a9krpnx/J9LDGv4/AHzrBPdVHzuU8IcATYmIF3kZ0+0YX4JDTV/jQEZHr4y7Yhh
f0LteOpBGofWeIHQP0uYS93WSD1AcNpnW0CrpuljX9PPFgjsT8ALP0QIr60/te3k
yuelToD+dR92iDGoBhFfR2q+DoPjKwkdnHuYDZouaq3YgBkNAnq4QDkWSLkHKOGd
43I0tKxIzVXKEpSEQOjvNJ56JlUT8n8PwWq/yS5s84GmUkeDO3/sJ0Zx0yF8ucwo
3+mE+BGIAW++bcGYiBvhJ573MDqsrag2MMfNpuP885xEjNXaFTKJykZCfP7J01qX
S1FdaLmVlWc=
=mpSt
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
