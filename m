Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTF1RHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 13:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTF1RHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 13:07:06 -0400
Received: from cpt-dial-196-30-178-116.mweb.co.za ([196.30.178.116]:55168 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S265298AbTF1RGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 13:06:53 -0400
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Roberto Orenstein <rstein@brturbo.com>
In-Reply-To: <200306290230.40059.kernel@kolivas.org>
References: <200306281516.12975.kernel@kolivas.org>
	 <200306290230.40059.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+HVWgpF2/q+xLCfq+U5s"
Organization: 
Message-Id: <1056820945.14725.33.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 28 Jun 2003 19:22:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+HVWgpF2/q+xLCfq+U5s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-06-28 at 18:30, Con Kolivas wrote:
> On Sat, 28 Jun 2003 15:16, Con Kolivas wrote:
> > For my sins I've included what I thought was necessary for this patch.
> >
> And just for good measure here is the latest with a slight addition that =
helps=20
> X smoothness over time. It gives the sleep_avg a little headroom so it=20
> doesn't drop from interactive as easily with bursts of cpu activity.

Have not tried this one, but previous had the same issues on this HT
box.  Reverted the two patches, and I have no mouse jerkyness or laggy
redraw of windows.

Anyhow, will it be a wise move to try and get a scheduler that works
fine for both UP and SMP ?


Regards,

--=20

Martin Schlemmer



--=-+HVWgpF2/q+xLCfq+U5s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/c7RqburzKaJYLYRAqKYAJ9mPSgzS+eWMa+pSN5byYBqLxH41gCeI+iV
1hf7nQ1D8O803ccpNNamBJQ=
=92FX
-----END PGP SIGNATURE-----

--=-+HVWgpF2/q+xLCfq+U5s--

