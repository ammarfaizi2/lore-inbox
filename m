Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWHCFoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWHCFoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHCFoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:44:55 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:37858 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932276AbWHCFoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:44:54 -0400
Message-ID: <44D18D4A.8080201@t-online.de>
Date: Thu, 03 Aug 2006 07:44:42 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <20060802101803.GH7601@ucw.cz>
In-Reply-To: <20060802101803.GH7601@ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92823E899F52344CA10AD5CC"
X-ID: GEvNz4ZvwejPZkBCuFebr490Newqh5mnnVciGt6JjpU1ag5uzcQWZ8
X-TOI-MSGID: 89ef9590-185c-44d2-890c-6e7a9b4ffba5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92823E899F52344CA10AD5CC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Pavel Machek wrote:
>=20
> How do you manage to spindown SATA disks? I tried hdparm -y, but that
> did not work iirc.
> 							Pavel
>=20

"hdparm -S"?

Please note that standard 3.5" disks are not made to spin
down every 5 minutes. This feature can reduce the lifespan
of your disk, AFAIK.


Regards

Harri



--------------enig92823E899F52344CA10AD5CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0Y1PUTlbRTxpHjcRAk6JAJ9RmGZ64QAV+k+RnDlWAGIfBpoPGwCfcobk
gfR26qjhULbujrfRidC+EuY=
=2cLv
-----END PGP SIGNATURE-----

--------------enig92823E899F52344CA10AD5CC--
