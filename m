Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTFTKUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTFTKUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:20:42 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:57728
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S262645AbTFTKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:20:34 -0400
Date: Fri, 20 Jun 2003 12:33:00 +0200
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620103300.GA2360@ghanima.endorphin.org>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620101452.GA2233@ghanima.endorphin.org> <20030620102455.GC26678@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20030620102455.GC26678@wotan.suse.de>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2003 at 12:24:55PM +0200, Andi Kleen wrote:
> On Fri, Jun 20, 2003 at 12:14:52PM +0200, Fruhwirth Clemens wrote:
> > There is no cryptoloop installation which is affected by this. Read my =
mail
> > properly. Every cryptoloop setup out there uses loop-AES or kerneli's
> > patch-int. And both fixed this issue a _long_ time ago. (Have a look at
>=20
> That's completely wrong. I know of several independent implementation
> and installations.

Can't you just name them?

Clemens

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+8uLcW7sr9DEJLk4RAuH7AJ9TB6WnV9qFu7FYImLe4q1AJ0e4wACdGhEu
34tazfT1sANNmo8F67OQA6Y=
=MGYJ
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
