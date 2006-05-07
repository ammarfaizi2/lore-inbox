Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWEGNJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWEGNJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWEGNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:09:24 -0400
Received: from master.altlinux.org ([62.118.250.235]:1805 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932148AbWEGNJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:09:23 -0400
Date: Sun, 7 May 2006 17:09:16 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Michael Buesch <mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>, mbuesch@freenet.de,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/6] New Generic HW RNG
Message-Id: <20060507170916.510a66d7.vsu@altlinux.ru>
In-Reply-To: <20060507113605.144341000@pc1>
References: <20060507113513.418451000@pc1>
	<20060507113605.144341000@pc1>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__7_May_2006_17_09_16_+0400_3pgOrI9S2r/I_MCL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__7_May_2006_17_09_16_+0400_3pgOrI9S2r/I_MCL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 07 May 2006 13:35:16 +0200 Michael Buesch wrote:

> Add a driver for the x86 RNG.
> This driver is ported from the old hw_random.c

In fact, this is 4 completely different drivers - probably they should
be split now?

--Signature=_Sun__7_May_2006_17_09_16_+0400_3pgOrI9S2r/I_MCL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEXfF8W82GfkQfsqIRAkg1AJsF33goT1RfsWPQ3y0bktFlYArG3ACeML0Q
7AaNCpdviCxQ1aYg/bCMjTk=
=zDnG
-----END PGP SIGNATURE-----

--Signature=_Sun__7_May_2006_17_09_16_+0400_3pgOrI9S2r/I_MCL--
