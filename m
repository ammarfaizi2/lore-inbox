Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUDGHYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUDGHYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:24:38 -0400
Received: from mailrelay03.sunrise.ch ([194.158.229.31]:11912 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id S264119AbUDGHYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:24:33 -0400
Date: Wed, 7 Apr 2004 09:24:19 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
Message-ID: <20040407072419.GE17419@puck.ch>
Mail-Followup-To: Olivier Bornet <Olivier.Bornet@puck.ch>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040404173646.GA15635@puck.ch> <40708569.7060403@stud.feec.vutbr.cz> <20040405221940.GA17419@puck.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <20040405221940.GA17419@puck.ch>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 06, 2004 at 12:19:40AM +0200, Olivier Bornet wrote:
> On Mon, Apr 05, 2004 at 12:00:09AM +0200, Michal Schmidt wrote:
> > Yes, see:
> >   http://bugzilla.kernel.org/show_bug.cgi?id=3D1415
> > There is a patch which worked for me.
>=20
> Thanks a lot. :-) This patch is working as expected for me.

A correction: I can now suspend to ram and resume. But it seems that the
laptop is not in a good state after suspend to ram. I have let it in
this mode the whole day, and when I was back at home, the battery was
empty. :-(

I don't have use this laptop (or even another one) with another
configuration for suspending to ram, so I don't realy know how much time
we can have it in the suspend to ram state before the battery is empty.
But talking with one friend, he say that with 2.4 kernel and APM, this
will be many weeks.

I'm ready to help with the ACPI stuff if this may be usefull. Just let
me know what I can test.

Good day, and thanks for your help.

		Olivier
--=20
Olivier Bornet                |    fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results      |    english  : http://puck.ch/e
http://puck.ch/               |    deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch        |    italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://pgp.mit.edu/

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAc6yjdj3R/MU9khgRArqIAKDEhj5HaBFojgGJDP1JCP31MalpYwCgscq3
l5k7GjjxvYRI0R4CaS+xUE4=
=dplz
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
