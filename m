Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVANEMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVANEMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVANEMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:12:50 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:21449 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261873AbVANEMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:12:47 -0500
Message-ID: <41E7468B.3050702@kolivas.org>
Date: Fri, 14 Jan 2005 15:11:55 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1105669451.5402.38.camel@npiggin-nld.site>	 <200501140240.j0E2esKG026962@localhost.localdomain>	 <20050113191237.25b3962a.akpm@osdl.org>  <41E739F4.1030902@kolivas.org> <1105673482.5402.58.camel@npiggin-nld.site>
In-Reply-To: <1105673482.5402.58.camel@npiggin-nld.site>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A7698D224E3B6F75413683B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A7698D224E3B6F75413683B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> It sounds to me like both your proposals may be too complex and not
> sufficiently deterministic (I don't know for sure, maybe that's
> exactly what the RT people want).

This is the solution already employed in the real world by OSX. It works
well, and the audio people have told me they are happy with it.

> I could be completely off the rails though. I haven't really been
> following this thread so please shoot me in my foot if I have put it
> in my mouth.

If your foot is in your mouth and you ask me to shoot you in the foot it
would blow your head off... Hmm it's tempting...

Cheers,
Con

--------------enig2A7698D224E3B6F75413683B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB50aLZUg7+tp6mRURAjYoAJ9KjJ/EbK17MZYhP5JFqzFJ5RaOrACfRnay
Dc2ElN3ZMar19hHuJKct9HA=
=erhg
-----END PGP SIGNATURE-----

--------------enig2A7698D224E3B6F75413683B--
