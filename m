Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUALJVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbUALJVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:21:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20699 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266105AbUALJVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:21:17 -0500
Date: Mon, 12 Jan 2004 10:20:59 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112092059.GC6677@devserv.devel.redhat.com>
References: <4002CC23.6000105@exavio.com.cn> <1073898527.4428.1.camel@laptop.fenrus.com> <20040112091903.GD24638@suse.de> <20040112091946.GA29779@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <20040112091946.GA29779@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2004 at 10:19:46AM +0100, Jens Axboe wrote:
>=20
> ... and still exists in your 2.4.21 based kernel.

The RHL 2.4.21 kernels don't have the locking patch at all...

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAmb6xULwo51rQBIRAlqYAJ4/+pCzGcJxvco+j0nnH+vgOOGVpQCeJD6b
Phk+n5yvpMQD/L9rNbZvuYo=
=vyhq
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
