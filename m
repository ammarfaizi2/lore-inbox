Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUJYG0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUJYG0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUJYG0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:26:24 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:29312 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261557AbUJYGZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:25:51 -0400
Date: Sun, 24 Oct 2004 23:25:46 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious stability issues with 2.6.10-rc1
Message-ID: <20041025062546.GA6361@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <pan.2004.10.25.01.20.55.763270@triplehelix.org> <417C9955.4030507@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <417C9955.4030507@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2004 at 02:12:37AM -0400, Jeff Garzik wrote:
> Could you please search through the various 2.6.9-bk snapshots, to see=20
> where this behavior starts?

This will take several days, because the bug doesn't manifest itself
that quickly..

I'll binary search bk1-bk7 though, and get back to you whenever I'm
done.

--=20
Joshua Kwan

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQXycaaOILr94RG8mAQLtIQ/9G6CS4rFd/vVauN2ZDfQzZCecwXsz8OLX
MbFjmV3uJmR6gx4o6s89knni69PpKgyKJWNCq6V/XofM8vkYPiGjbasCt4SOleew
tzbPSpMwuOpspTWXlk74pfIJ/1a/h48HuCaahkMsxQRzbgfBTkJ7Ccp7CvEW6fjj
KywxAfOi1RoEktWdunQOeWkl/x48WZYqjdcB8wVplbmY9M3MBMqzO4yiHal4fwOJ
KxUKg2ZyDlnJP00PZsiwfcgDLWZIJDYkniVBjL+fsU0URQrVW46JPT5gxDHDzPeK
AGX9ejDtFx2oMv3EDkHpqG7gyFWvUU6X9bP8Jd8r14oYjamz/2PQBeSeSMZAUaiO
vMyFLrZTkmhQrmh3FrEbsVKKeaS6v/EhYytmx2KdXrGLFHAUGLQae3W+3qE/wNCy
dRcqdf0I1b0pZ91aViXAEW28al4aVP6q0slkhODUXWz3qC8hi+sPQD4i/MuGALxZ
TWZs4nW7nSGbLfLl5MS5it7PyluT755rEIDL0iTR/3sIVhTTIUAl+FhWousdp2XC
+VUD3Bf9K7eNn0UFFuCTkDLWbpKIWhl6IOq8aHGmKPk+UQz+DwPS1kjTPA+ZA4eC
pg2F9/FRNONQTDVrKX0dilBqZQz/DLhJj21maMAUfYwsxTOZzHHhbPqt44U8+1Im
IhoYO7a1bPo=
=WM3W
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
