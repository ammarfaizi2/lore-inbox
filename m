Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUHVIyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUHVIyA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 04:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHVIyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 04:54:00 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:42402 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266539AbUHVIx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 04:53:58 -0400
Date: Sun, 22 Aug 2004 10:53:22 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: roland@redhat.com, torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: [PATCH] waitid system call
Message-ID: <20040822085322.GA19768@thundrix.ch>
References: <28571.1092981652@www22.gmx.net> <20310.1092992556@www22.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20310.1092992556@www22.gmx.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Aug 20, 2004 at 11:02:36AM +0200, Michael Kerrisk wrote:
> Someone has supplied with me with a data point for Irix 6.5=20
> (and 6.2).  Irix behaves like Solaris 8.  So that's 3 out=20
> of 3 for the "si_pid =3D=3D 0" behavior (plus a buggy HP-UX 11).
> I will try to get a Unixware data point, but that will=20
> probably take several days.  (I wonder if anyone can supply=20
> an AIX data point?)

If required I can test it on a RS/6000 next week.

			Tonnerre

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBKF8A/4bL7ovhw40RAigyAJ4y7NpX21mw9mqcLqM77y29qQ5aVQCfbMfi
MQFgY1GiG2T+1h9wT90XFSc=
=QjsO
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
