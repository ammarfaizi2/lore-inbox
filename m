Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSETTuw>; Mon, 20 May 2002 15:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316305AbSETTuv>; Mon, 20 May 2002 15:50:51 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:24040 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316300AbSETTuv>; Mon, 20 May 2002 15:50:51 -0400
Date: Mon, 20 May 2002 15:42:44 -0400
From: Andrew Rodland <arodland@noln.com>
To: Jan Hudec <bulb@ucw.cz>
Subject: Re: Planning on a new system
Message-Id: <20020520154244.2bfb882e.arodland@noln.com>
In-Reply-To: <20020520192136.GC25125@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.7.5claws25 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="_wYTFc=.5t?xITcA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--_wYTFc=.5t?xITcA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2002 21:21:36 +0200
Jan Hudec <bulb@ucw.cz> wrote:

> On Sun, May 19, 2002 at 09:07:58PM -0400, Louis Garcia wrote:
> > Graphics adapter 32MB NVIDIA ? GeForce2? MX200 AGP Graphics
> 
> AFAIK there some binary-only driver for this card, that causes trouble
> time to time and as it's binary only, no one can debug them.
> I am not sure what really requres the driver, that is how much X can
> do without it.

You get 2d, semi-accelerated (that is, XAA only) graphics, at whatever
resolution you want, with X's "nv" driver.

Installing the NVidia kernel stuff + other libraries gets you better
acceleration on X, Render, Xv, and of course hardware-accelerated GLX.

It's actually not a bad card, lots of speed and decent quality... but
the module is occasionally flaky, and, of course, undebuggable. :)

--hobbs

--_wYTFc=.5t?xITcA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE86VG4Q3MWXxdwvVwRAm6RAKCEtwwWR0S0IG3FPyBplZeZVERFrQCdHlXp
We0KnhbMKUMfOm0Yg+NpeVA=
=Go8v
-----END PGP SIGNATURE-----

--_wYTFc=.5t?xITcA--
