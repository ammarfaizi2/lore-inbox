Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTEBPTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTEBPTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:19:04 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:46638 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S262941AbTEBPTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:19:03 -0400
Subject: Re: Centrino
From: Anders Karlsson <anders@trudheim.com>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030502085720.GA629@localhost.localdomain>
References: <1051851208.2846.84.camel@marx>
	 <20030502085720.GA629@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jT9OCZFQIlMi+PbEvtyP"
Organization: Trudheim Technology Limited
Message-Id: <1051889480.3331.40.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 02 May 2003 16:31:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jT9OCZFQIlMi+PbEvtyP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-05-02 at 09:57, Balram Adlakha wrote:
[snip]
>=20
> You mean the video card doesn't work properly? What happens when you run =
X etc?
> Are you have trouble booting your centrino notebook or something?
> The video card has got nothing to do with the cpu. Your centrino=20
> notebook should work normally. If you want to save power then you can=20
> select the power saving options in the config.

Well, the vided card does work, but seemingly not after you restart your
X server. You get presented with a black screen after restarting X, and
you can kill the X server from there, so it runs, just doesn't show
anything.

The thinkpad boots, that is no problem. The powersaving has been brought
to my attention as a possible source of problem. I already run it w/o
ACPI, and will try disabling APM as well..

The other thing that has been highlighted to me is that there might be a
problem with idle in the 2.4.20 kernel. I will be trying 2.4.21-rc1 over
the weekend if that works better.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-jT9OCZFQIlMi+PbEvtyP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+so9ILYywqksgYBoRAvK7AKDZ3v0ST4H9FPZXq+5Z3+V+A9qvjwCgr7j1
PAwLquT7/qfjgdccOU3upnk=
=kogS
-----END PGP SIGNATURE-----

--=-jT9OCZFQIlMi+PbEvtyP--

