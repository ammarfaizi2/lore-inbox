Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUHKJEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUHKJEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUHKJEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:04:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268003AbUHKJEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:04:02 -0400
Subject: Re: Allow userspace do something special on overtemp
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Pavel Machek <pavel@suse.cz>
Cc: trenn@suse.de, seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <20040811085326.GA11765@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-moTQIL0PlhLuPEvjykgn"
Organization: Red Hat UK
Message-Id: <1092215024.2816.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 11:03:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-moTQIL0PlhLuPEvjykgn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-11 at 10:53, Pavel Machek wrote:
> Hi!
>=20
> This patch cleans up thermal.c a bit, and adds possibility to react to
> critical overtemp: it tries to call /sbin/overtemp, and only if that
> fails calls /sbin/poweroff.

why not call /sbin/hotplug ????


--=-moTQIL0PlhLuPEvjykgn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGeDwxULwo51rQBIRApPIAJ4jZhDdgFHexNtyk/EY925BaxZMeACeLJQ1
q00WiK62AZWPDG33rhe6oyM=
=+qKO
-----END PGP SIGNATURE-----

--=-moTQIL0PlhLuPEvjykgn--

