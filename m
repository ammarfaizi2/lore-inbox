Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUAEMYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbUAEMYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:24:51 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:64642 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264310AbUAEMYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:24:47 -0500
Subject: Re: Kernel panic.. in 3.0 Enterprise Linux
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: neel vanan <neelvanan@yahoo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040105115610.49148.qmail@web9505.mail.yahoo.com>
References: <20040105115610.49148.qmail@web9505.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cnX9OSJdudH5RWo3bSBU"
Organization: Red Hat, Inc.
Message-Id: <1073305477.4429.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Jan 2004 13:24:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cnX9OSJdudH5RWo3bSBU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 12:56, neel vanan wrote:
> Hi all,
>=20
> The kernel I have working is version 2.4.21-4.EL and I
> can still boot up to that. I compiled a 2.6.0 version
> and installed it in exactly the same way that the old
> version is, just appending 2.6.0 to the end of the
> file. so when I reboot I get a boot screen that shows:
>=20
> Red Hat Enterprise Linux AS (2.4.21-4.ELsmp)
> Red Hat Enterprise Linux As-up (2.4.21-4.EL)
> Red Hat linux (2.6.0)

RHEL3 isn't quite 2.6 ready btw; you need to update quite a few packages
to get it working right.

Also if you use mount-by-label you do need to create an initrd (with a
2.6 capable mkinitrd)...


--=-cnX9OSJdudH5RWo3bSBU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+VeFxULwo51rQBIRAtp4AKCQ0JzSiLAxlzX6QvctxMk554byLgCghF9k
e6oIgvZlKFh4/nWfNcAQHdw=
=o0DH
-----END PGP SIGNATURE-----

--=-cnX9OSJdudH5RWo3bSBU--
