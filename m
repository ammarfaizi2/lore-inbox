Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280834AbRKGQLu>; Wed, 7 Nov 2001 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280839AbRKGQLk>; Wed, 7 Nov 2001 11:11:40 -0500
Received: from [194.51.220.145] ([194.51.220.145]:15707 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S280838AbRKGQL1>;
	Wed, 7 Nov 2001 11:11:27 -0500
Date: Wed, 7 Nov 2001 17:06:39 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: David Megginson <david@megginson.com>
Cc: Massimo Dal Zotto <dz@cs.unitn.it>, linux-kernel@vger.kernel.org
Subject: Re: i8kutils
Message-ID: <20011107170638.A6879@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <15336.42604.800408.258987@megginson.com> <200111071242.fA7CgmcY001822@dizzy.dz.net> <15337.16719.669560.795605@megginson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <15337.16719.669560.795605@megginson.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2001 at 09:12:31AM -0500, David Megginson wrote:
> Thanks.  I'm using something like this now, but I was hoping to find a
> program that could toggle the mute rather than just dropping the
> volume to 0.  I'll figure out a work-around.

I use gkrellm with gkrellvolume plugin. I send a SIGUSR1 to gkrellm, and
it toggles mute.

	Stephane.

--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvpXA4ACgkQk2dpMN4A2NM5qACeIXxBSF+RvJbUhMEasYLa0e1I
5jMAn1b8lzghRYCmxJ4gHPgIi1ZhtR6p
=iWyd
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
