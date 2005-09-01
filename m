Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVIASBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVIASBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVIASBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:01:18 -0400
Received: from mail.gmx.de ([213.165.64.20]:52443 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030269AbVIASBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:01:17 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: "John Stoffel" <john@stoffel.org>
Subject: Re: 2.6.13-mm1
Date: Thu, 1 Sep 2005 20:05:10 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org> <200509011828.13579.dominik.karall@gmx.net> <17175.15252.782903.646427@smtp.charter.net>
In-Reply-To: <17175.15252.782903.646427@smtp.charter.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2396841.Mbux2STQK7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509012005.18369.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2396841.Mbux2STQK7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 01 September 2005 19:34, John Stoffel wrote:
> Dominik,
>
> So what is the chipset inside the enclosure?  Looking at your output,
> the 'Argosy' stuff doesn't tell me anything.  You might have to open
> up the case to look in there to find more details.
>
> Again, check with your vendor and see if there is newer firmware.  And
> have you powered up the device without having it plugged into the
> system, then plug it in?  What happens then?

Why should I check for newer firmware!? I don't understand that point of vi=
ew.=20
The device works without any problems with 2.6.13-ck1 as 2.6.13-rc6-mm1 and=
=20
before kernels. So there is no need to check the firmware imho.

I don't think that it makes any difference if I power up first or plug in=20
first. The device is recognized when I power it on, so it would be the same=
=20
when I power it on and connect after that imho.

I will try to get the backtraces from the kernel, this should make debuggin=
g=20
easier.

greets,
dominik

--nextPart2396841.Mbux2STQK7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQxdC3gvcoSHvsHMnAQJcFwP/SZA0I9qIS4sMjLyJ36Ua8SML1Lifj03u
brXwPT0mir/X2Tdecso6efHws4OO9K+stgL7VQCgPA6ly2JKXlqbV73JlJPT8T/a
C7/qjBoaV8XClTYVsaNh8+8ljJwIbgNVWrdWGnosRaZhRuXwXzy5/kE1FYTN8z4u
yvMpvTqiJn8=
=lC+t
-----END PGP SIGNATURE-----

--nextPart2396841.Mbux2STQK7--
