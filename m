Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWAYTAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWAYTAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWAYTAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:00:31 -0500
Received: from nsm.pl ([62.111.143.37]:6940 "EHLO nsm.pl") by vger.kernel.org
	with ESMTP id S932105AbWAYTA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:00:29 -0500
Date: Wed, 25 Jan 2006 20:00:14 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, axboe@suse.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125190013.GA6135@irc.pl>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jengelh@linux01.gwdg.de, axboe@suse.de, rlrevell@joe-job.com,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	acahalan@gmail.com
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <43D7AF56.nailDFJ882IWI@burner>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2006 at 06:03:18PM +0100, Joerg Schilling wrote:
> Jens Axboe <axboe@suse.de> wrote:
>=20
> > You just want the device naming to reflect that. The user should not
> > need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
> > likely be using k3b or something graphical though, and just click on his
> > Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
> > help do this dynamically even.
>=20
> Guess why cdrecord -scanbus is needed.
>=20
> It serves the need of GUI programs for cdrercord and allows them to retri=
eve=20
> and list possible drives of interest in a platform independent way.

  GUI programs tend to retrieve this kind of info form HAL
(http://freedesktop.org/wiki/Software_2fhal)

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFD18q9ThhlKowQALQRAuOnAJ9Kzs/hsxwhB5i2t8u8dZf4mHyqlACghQGX
ZxR4TD6icRb/tcpNkkyI4hA=
=Ovs8
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
