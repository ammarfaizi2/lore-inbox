Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVKLUt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVKLUt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVKLUt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:49:57 -0500
Received: from ctb-mesg8.saix.net ([196.25.240.78]:64486 "EHLO
	ctb-mesg8.saix.net") by vger.kernel.org with ESMTP id S964796AbVKLUt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:49:57 -0500
Subject: Re: PROBLEM: No initialization of sound card
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Pelle =?ISO-8859-1?Q?Lundstr=F6m?= <lunper@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b1952ae90511121243q6c7e4c87x4f7bd99f7d3a86ee@mail.gmail.com>
References: <b1952ae90511121243q6c7e4c87x4f7bd99f7d3a86ee@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Lx/SyAKkZT2WBi288L9E"
Date: Sat, 12 Nov 2005 22:53:28 +0200
Message-Id: <1131828808.19428.9.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lx/SyAKkZT2WBi288L9E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-11-12 at 21:43 +0100, Pelle Lundstr=C3=B6m wrote:
> 1. Kernel 2.6.14.2 fails to locate and initiate sound card.
>=20

<snip>

> 8.7. Relevant dmesg output:
> Nov 12 08:38:02 scofield modprobe: WARNING: Error inserting snd
> (/lib/modules/2.6.14.2/kernel/sound/core/snd.ko): Unknown symbol in
> module, or unknown param
> eter (see dmesg)

<snip>

Above looks like syslog snippet, and not dmesg.  I would suggest
including the actual output of the 'dmesg' command, as it very possibly
will reveal missing symbols or some other issue.


Regards,

--=20
Martin Schlemmer


--=-Lx/SyAKkZT2WBi288L9E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDdlZIqburzKaJYLYRAjGwAJ9tR8sVPnm2f4G488gwDlZIX2Kj+wCfQ9j0
9Vlg0OyWmeXlg+eF4n9BjYE=
=Yni1
-----END PGP SIGNATURE-----

--=-Lx/SyAKkZT2WBi288L9E--

