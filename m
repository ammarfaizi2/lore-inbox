Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWCUAH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWCUAH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCUAH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:07:59 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:12496 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751369AbWCUAH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:07:58 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: SubmittingPatches typo
Date: Tue, 21 Mar 2006 10:06:00 +1000
User-Agent: KMail/1.9.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20060320125012.GA21545@elf.ucw.cz>
In-Reply-To: <20060320125012.GA21545@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2250450.IqYHotC3iE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603211006.04681.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2250450.IqYHotC3iE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 March 2006 22:50, Pavel Machek wrote:
> Hi!
>
> I'm not 100% sure with my english, but this seems wrong...
>
> Signed-off-by: Pavel Machek <pavel@suse.cz>
>
> diff --git a/Documentation/SubmittingPatches
> b/Documentation/SubmittingPatches index c2c85bc..8fd6d4e 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -490,7 +490,7 @@ NO!!!! No more huge patch bombs to linux
>  Kernel Documentation/CodingStyle
>    <http://sosdg.org/~coywolf/lxr/source/Documentation/CodingStyle>
>
> -Linus Torvald's mail on the canonical patch format:
> +Linus Torvalds' mail on the canonical patch format:
>    <http://lkml.org/lkml/2005/4/7/183>
>  --
>  Last updated on 17 Nov 2005.

I read all the other messages, and still felt I needed to reply :).

This patch is correct. If a name ends in an s, the possessive form simply g=
ets=20
an apostrophe.

Plurals are irrelevant to the discussion, but I'll answer another part of t=
he=20
thread too. If you wanted to say that something belonged to Linus and his=20
family, you'd still do Torvalds', and get the fact that Torvalds was in the=
=20
plural from other words in the context (if possible).

Regards,

Nigel

--nextPart2250450.IqYHotC3iE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEH0NsN0y+n1M3mo0RAqo6AKDKc6IrOhZ8NHBSchcLekdFZ06fXQCeOE/y
IoTKQytX6IxOe4AnQI1PYys=
=xUaS
-----END PGP SIGNATURE-----

--nextPart2250450.IqYHotC3iE--
