Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVG0WOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVG0WOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVG0WMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:12:54 -0400
Received: from [84.77.83.123] ([84.77.83.123]:16320 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S261192AbVG0WLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:11:01 -0400
Date: Thu, 28 Jul 2005 00:10:50 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [2.6.12-git8] ACPI shutdown fails to power off machine
Message-ID: <20050727221050.GA4094@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
References: <20050709203402.GA4621@localhost> <m1r7dvgjs9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <m1r7dvgjs9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday, 19 July 2005, at 04:41:26 -0600,
Eric W. Biederman wrote:

> Roughly for your part of the problem the acpi shutdown code needs to
> get called sooner when interrupts are still enabled.=20
>=20
After the recent patches that went in to the kernel, I downloaded version
2.6.13-rc8-git8, compiled, and now the box powers off correctly. Seems my
setup is working fine again now. However, I didn't check if this is
working ok all the times, because it seems in another thread that someone
is having problems to get his system powering off reliably.

But the precise problem I reported is gone. Thank you Eric.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc3-git8)


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6AZqao1/w/yPYI0RAmF1AJ4lmnv7kW9zRllagRIcA9e3UGTfVACePFKV
UQHGQ8SiNl0RwGqCPr6Iyio=
=qy/1
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
