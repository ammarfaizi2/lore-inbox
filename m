Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWEXKJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWEXKJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 06:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWEXKJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 06:09:20 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:63976 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932670AbWEXKJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 06:09:19 -0400
Subject: Re: [PATCH] make ams work with latest kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Stelian Pop <stelian@popies.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1148465069.6723.26.camel@localhost.localdomain>
References: <1148383943.25971.2.camel@johannes>
	 <1148465069.6723.26.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ej3EoGGJMroCynMboPkt"
Date: Wed, 24 May 2006 12:09:05 +0200
Message-Id: <1148465350.11734.33.camel@johannes>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ej3EoGGJMroCynMboPkt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-24 at 12:04 +0200, Stelian Pop wrote:

> Version 0.3 of ams (from http://popies.net/ams/) already had all those
> changes :)

Oh heh. :I downloaded the 2 version a while ago and forgot to check for
updates before fixing it up.

> The latest version (0.4) has some additionnal changes (fixes a double
> free induced by the use of input_free_device(), some other more cosmetic
> changes).

Nice :)

> Here it comes, along with proper kernel integration (Johannes, I've kept
> your Signed-off-by since the code is almost the same, feel free to
> disagree loudly if you must :) ).

:)
Patch looks good, thanks.

johannes

--=-ej3EoGGJMroCynMboPkt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHQwvqVg1VMiehFYAQKIcg//aBgdH0EWod+vJ5FD1I+uW2hkgMORNKjK
D+9eqiBUOMRUl4wVtUptDsNH9EaX3lI/owfh/4u6ZrduwLqR75VhO4Mt0IRmpsrL
tyRyBNSmJjzT2hn12IrNXmMaRnpisvSLhrs8SawGbZ0uadKlyaw0Z5cDCoykhqMC
C+yLUtOKrGsHc2uQ1zac9Ks6tOlNlhlPZKkx/W/HRCcY5lgFO1VGfmK2r6n2Ft6p
i3MdeejEV55T/9wk3Rv7G4qbJ8rTo5cMsKwqhKIxmFBggYQNtNE0Q0d9MkKawGLY
A56A1lA+RcVHSoXqxRrUK86gq7pEr2aDYuQ/XqJ14qdI3zY6N0NRiMQol8tOrcx/
9a2sUi3qQ+VwQnW7g1OEaenGMG78L4+II32gXbEG4y5gn9FaGyfBUJVq1L9BroIV
5mafRhaVQMHMk8tKmoYgdsDpeML5K4/5hR/JSJ6rqYqeM/kU28+GSQ6SK70/a6gN
uHlSTBzy7RRD05x+WsmssdnvxUAVYK+lw/ODjSAb7mYU3xn/pRKut/u/jwQMd/zS
mlKxP+UKPxeHy6XMikPbu9KL3U4cktpd8qObiXS2j8QaotKuxZxTdL12+OGL0dXh
n9sYREg6+6FPCpO1HBkfviHzq07ekgMiD0K2Uj/mnnVvYntQqet5yX7lSELjoOGv
pxh71P5sNog=
=uGSo
-----END PGP SIGNATURE-----

--=-ej3EoGGJMroCynMboPkt--

