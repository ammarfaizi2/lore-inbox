Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbUL0UAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUL0UAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUL0T7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:59:50 -0500
Received: from dhcp93115068.columbus.rr.com ([24.93.115.68]:4105 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261973AbUL0T6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:58:52 -0500
Date: Mon, 27 Dec 2004 14:58:39 -0500
To: Marko Dimiskovski <marko.dimiskovski@gmail.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: reltime preemption: kernel oops in dri module i810
Message-ID: <20041227195839.GA4369@zion.rivenstone.net>
Mail-Followup-To: Marko Dimiskovski <marko.dimiskovski@gmail.com>,
	mingo@elte.hu, linux-kernel@vger.kernel.org
References: <80d5517604122615207069056f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <80d5517604122615207069056f@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 26, 2004 at 06:20:45PM -0500, Marko Dimiskovski wrote:
> got some errors with the i810 and the realtime-preemption patch :-\
> the kernel version is 2.6.10-rc3-mm1-V0.7.33-04 as you can see from
> the attached config file and the message file has the oops in it.=20
> hope this helps.

    This is not a problem with the realtime-preemption patch but a bug
in the i810 drm module in the -mm kernels.  I've been getting this
too, and have reported it to the dri developers on the dri-devel list.

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB0GlvWv4KsgKfSVgRAnMhAKCOWZWtd6VFSVauhu8IhWHS8TeeIQCfeyB+
nXEpf6fz4izA0c+GE3IlLY8=
=pO7c
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
