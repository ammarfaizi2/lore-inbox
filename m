Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUFRGkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUFRGkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 02:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUFRGkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 02:40:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14765 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265005AbUFRGkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 02:40:23 -0400
Subject: Re: Stop the Linux kernel madness
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <40D232AD.4020708@opensound.com>
References: <40D232AD.4020708@opensound.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+j4vPRnJjN2qmTTMBz+l"
Organization: Red Hat UK
Message-Id: <1087540814.2709.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 18 Jun 2004 08:40:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+j4vPRnJjN2qmTTMBz+l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 at 02:09, 4Front Technologies wrote:
> Hi Folks,
>=20
> I am writing this message to bring a huge problem to light. SuSE has been=
 systematically
> forking the linux kernel and shipping all kinds of modifications and stil=
l call their
> kernels 2.6.5 (for example).

internal kernel apis change and are fair game. As a RH kernel maintainer
I can guarantee you that you will suffer too from internal kernel
changes in RH/Fedora kernels. Or from changes within the 2.6.x series.
Linux needs such changes to allow faster and cleaner development.
The cost is on the external modules; it has a good side too, it provides
an incentive for external modules to merge into the kernel so that they
get fixed automatic. Having such incentives is in my opinion a good
thing.


--=-+j4vPRnJjN2qmTTMBz+l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0o5OxULwo51rQBIRAv0KAJ0dom7lzYdm+G/xW9tR/ecX26RT0gCdH3Bb
avJ2geBra8cdCl9DInISYrM=
=NWga
-----END PGP SIGNATURE-----

--=-+j4vPRnJjN2qmTTMBz+l--

