Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWE3XiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWE3XiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWE3XiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:38:18 -0400
Received: from amnesiac.heapspace.net ([195.54.228.42]:61445 "EHLO
	amnesiac.heapspace.net") by vger.kernel.org with ESMTP
	id S964823AbWE3XiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:38:17 -0400
Date: Wed, 31 May 2006 02:38:13 +0300
From: Daniel Stone <daniel@fooishbar.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060530233813.GC16521@fooishbar.org>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	"D. Hazelton" <dhazelton@enter.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Manu Abraham <abraham.manu@gmail.com>,
	linux cbon <linuxcbon@yahoo.fr>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com> <20060530202401.GC16106@elf.ucw.cz> <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com> <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com> <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ByM1h5nouWwd3kz8"
Content-Disposition: inline
In-Reply-To: <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ByM1h5nouWwd3kz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2006 at 07:27:25PM -0400, Jon Smirl wrote:
> On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> >Actually the suspend/resume has to be in userspace, X just re-posts
> >the video ROM and reloads the registers... so the repost on resume has
> >to happen... so some component needs to be in userspace..
>=20
> I'd like to see the simple video POST program get finished.

http://archive.ubuntu.com/ubuntu/pool/main/v/vbetool/

--ByM1h5nouWwd3kz8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEfNdlRkzMgPKxYGwRArYlAJ4uq4pUKTjqZhZHzxbkokKrm+IOYgCghysl
0Eq/Cydw0EPk6hcoX0m5SQE=
=QgsW
-----END PGP SIGNATURE-----

--ByM1h5nouWwd3kz8--
