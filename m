Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUJIHLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUJIHLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 03:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUJIHLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 03:11:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266611AbUJIHLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 03:11:31 -0400
Subject: Re: autofs panic, linux 2.4.21-15.EL.c0smp
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Craig, Dave" <dwcraig@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0320111483D8B84AAAB437215BBDA526D60686@NAEX01.na.qualcomm.com>
References: <0320111483D8B84AAAB437215BBDA526D60686@NAEX01.na.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TsK9jwGlXBmRj0wR4JCY"
Organization: Red Hat UK
Message-Id: <1097305880.2790.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 09:11:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TsK9jwGlXBmRj0wR4JCY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-10-09 at 02:18, Craig, Dave wrote:
> loop vfat fat nfs sr_mod ide-cd cdrom dcdipm dcdbas nfsd lockd sunrpc lp
> parport autofs ppp_async ppp_generic slhc tg3 ipv6 floppy sg microcode
> keybdev moused
> CPU:    0
> EIP:    0060:[<c017c362>]    Tainted: PF
> EFLAGS: 00010207


you could start by not using binary only kernel modules; next step would
be to run a kernel that some vendor supports and then complain to that
vendor ;)
(I don't know who made the kernel  you are running, but it's not Red
Hat)

--=-TsK9jwGlXBmRj0wR4JCY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBZ48Ypv2rCoFn+CIRAgGHAJ9sbl9sZQPu6KNlJB3YxRTPEq6oOwCdGxOu
1W9LKrElCXwbr2COYTDalHg=
=uUrG
-----END PGP SIGNATURE-----

--=-TsK9jwGlXBmRj0wR4JCY--

