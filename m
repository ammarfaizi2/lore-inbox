Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbUKKEEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbUKKEEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUKKEEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:04:07 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:17848 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262167AbUKKEDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:03:51 -0500
Date: Wed, 10 Nov 2004 20:03:46 -0800
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious stability issues with 2.6.10-rc1
Message-ID: <20041111040346.GA2815@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <pan.2004.10.25.01.20.55.763270@triplehelix.org> <417C9955.4030507@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <417C9955.4030507@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2004 at 02:12:37AM -0400, Jeff Garzik wrote:
> Could you please search through the various 2.6.9-bk snapshots, to see=20
> where this behavior starts?

OK, after long periods of testing things, it seems to be a change that
happened between 2.6.9-bk7 and 2.6.10-rc1.

I have an interdiff generated, I can't really see what would cause the
problem... IANAKH though. ideas?

--=20
Joshua Kwan

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQZLkoaOILr94RG8mAQLxMg//WStjmvXpNfycibMc7UBUeXoAZzYE3TB0
hEmtzqdfnJDJ4IMKBVS46mObaHwNOaqPss8TyKBivyQXo7rgtlDe5g8e4PHnkqk4
NXvO6jRVI/8b04K8WM3nVYtrbPt+r40THZZPAviAxPNZRCKd2ll0ebuMWx85OLQP
ZlAY1QFu4fjXsgCaUOmt1YWHH2yaliqeQKYA2+lWL6nYqfZiwPv1cTqLwrnpsHmk
KIMsBsVaTPW990UEhd7Jx+3zm36T6Nc5S65LlAoPcBVGG37XtjwKAT8GMlnBwsRv
mUoXz9v7ODahX4P7AAhQnJwWXdhPkna5+WT2SxqV/w+xxAlxRfufXQrfZPNZreSj
L8lCQqyWt0cxLV/ul4I6G448IWqUPnOuiQuKRIlGz0CXt16GfNhBWRUkEUpjRo08
XO9AvsPK7k/rwHd2i8uYQnAnr7bD+y2Coc8tbYXhw1TPDe2gaiw64R/OZ9WgsNyi
RZ4HD+X24Umr4PNkRlb251U4P25AfudruLLi2mk743AXkUwSGWgmy/EHsMkFsWkv
sx/lNZulpjTub2QoyhmL5at9thUfdJZyt+elRmqHN1UBXY4k5dskgJGTNgng2Sbh
RN0+CMgyK/DtO0xfv8xZN9/OU7pnPA1PZv/ECbYkokqUHa2j9aXrcJQ/Na4TprKa
TQLGOeucN0k=
=/NDm
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
