Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVAQTP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVAQTP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVAQTP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:15:27 -0500
Received: from use.the.admin.shell.to.set.your.reverse.dns.for.this.ip ([80.68.90.107]:33028
	"EHLO irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262588AbVAQTPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:15:17 -0500
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
From: Fruhwirth Clemens <clemens@endorphin.org>
To: linux-kernel@vger.kernel.org
Cc: Bill Davidsen <davidsen@tmr.com>, linux-crypto@nl.linux.org,
       James Morris <jmorris@redhat.com>
In-Reply-To: <41EBD4D4.882B94D@users.sourceforge.net>
References: <41EAE36F.35354DDF@users.sourceforge.net>
	 <41EB3E7E.7070100@tmr.com>  <41EBD4D4.882B94D@users.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4vDeYAWr9bs7TaUpMeie"
Date: Mon, 17 Jan 2005 20:14:58 +0100
Message-Id: <1105989298.14565.36.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4vDeYAWr9bs7TaUpMeie
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-17 at 17:08 +0200, Jari Ruusu wrote:
> Bill Davidsen wrote:
> > Is this eventually going in the mainline kernel? I'd like to use it, bu=
t
> > if I'm going to have to maintain my own crypto kernels indefinitely thi=
s
> > probably isn't the one for me.
>=20
> Unlikely to go to mainline kernel. Mainline folks are just too much in lo=
ve
> with their backdoored device crypto implementations [1].=20

This is FUD. To get serious in-depth information about the problems
associated with dm-crypt and loop-aes read,

http://clemens.endorphin.org/LinuxHDEncSettings

This document has been reviewed by a couple of noteworthy people, also
partially to counter the on-going FUD postings, Jari Ruusu has been
posting to LKML repeatedly.

James Morris: Can we please talk about the merge of my LRW patches soon?
The insecurity of CBC based encryption such as dm-crypt and loop-aes is
the reason why I have been pushing this patch so hard for the last two
months now.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-4vDeYAWr9bs7TaUpMeie
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB7A6yW7sr9DEJLk4RAoEAAJ4nC+XN+g1kjSGRof+heahTsLxLPgCfeBR7
ieTNUbfTg2Hk2UwdiXSglRw=
=k5Ov
-----END PGP SIGNATURE-----

--=-4vDeYAWr9bs7TaUpMeie--
