Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUGZBKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUGZBKS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUGZBKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:10:18 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:15814 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264770AbUGZBKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:10:10 -0400
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040725174849.75f2ecf6.akpm@osdl.org> <cone.1090803691.689003.20693.502@pc.kolivas.org>
Message-ID: <cone.1090804198.848689.20693.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Date: Mon, 26 Jul 2004 11:09:58 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-20693-1090804198-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-20693-1090804198-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Con Kolivas writes:

> Andrew Morton writes:

>> Seriously, we've seen placebo effects before...
> 
> I am in full agreement there... It's easy to see that applications do not 
> swap out overnight; but i'm having difficulty trying to find a way to 
> demonstrate the other part. I guess timing the "linking the kernel with full 
> debug" on a low memory box is measurable.

I should have said - finding a swappiness that ensures not swapping out 
applications with updatedb, then using that same swappiness value to do the 
linking test.

Con


--=_mimegpg-pc.kolivas.org-20693-1090804198-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBFnmZUg7+tp6mRURAiBrAJ9RC4hNX73ysfVmeuOgfQfF6NGt6gCeMBG6
VuFip1C3OtUcc3s8XP9VGn4=
=lVkL
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-20693-1090804198-0001--
