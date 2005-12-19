Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVLSWig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVLSWig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVLSWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:38:36 -0500
Received: from mail.gmx.de ([213.165.64.21]:57483 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964949AbVLSWif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:38:35 -0500
X-Authenticated: #5082238
Date: Mon, 19 Dec 2005 23:38:36 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel e1000 fails after RAM upgrade
Message-ID: <20051219223836.GA10765@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2005 at 08:54:58PM +0100, Carsten Otto wrote:
> After upgrading the memory to 4 GB I noticed my e1000 did not work.

The problem also exists when I remove 2 GB. So it has to do something
with the kernel update in between. I will downgrade the kernel now until
this is solved.
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDpzZsjUF4jpCSQBQRAmBJAKDgwyKq0/hQHAcPr6tmUcicJO+vQACgwD9T
QuuYheLT9pJCDmbkXeFE2JY=
=1WT0
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
