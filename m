Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVCPQGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVCPQGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVCPQGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:06:47 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:16094 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S262661AbVCPQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:06:23 -0500
Message-ID: <42385986.6060702@arcor.de>
Date: Wed, 16 Mar 2005 17:06:30 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050222)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK snapshots broken
References: <4238487F.5050708@didntduck.org>
In-Reply-To: <4238487F.5050708@didntduck.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E79F2F787FEC3C32EF090A8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E79F2F787FEC3C32EF090A8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Brian Gerst schrieb:
> The snapshots on kernel.org are being created from the most recent tag
> in the BK repo, which is 2.6.11.3.  That means they are missing all of
> the changesets between the 2.6.11 and 2.6.11.3 tags, and don't apply to
> a clean 2.6.11 tree.

Furthermore I miss incremental patch. I wouldn't mind if bk now bases of
2.6.11.x kernel, but there is not .3-bk1 to .3-bk2 patch. :-/

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enig4E79F2F787FEC3C32EF090A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCOFmJxU2n/+9+t5gRAqzfAKDRLLZc/kmQ532yIkU/+jg0DUBaqACcDW7X
bfLNHkfoIxb6nAoNc3JLzLU=
=KVz9
-----END PGP SIGNATURE-----

--------------enig4E79F2F787FEC3C32EF090A8--
