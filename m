Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVELKtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVELKtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVELKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:49:51 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:9665 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261428AbVELKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:49:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [SMP NICE] [PATCH 2/2] SCHED: Make SMP nice a config option
Date: Thu, 12 May 2005 20:49:29 +1000
User-Agent: KMail/1.8
Cc: AndrewMorton <akpm@osdl.org>, Carlos Carvalho <carlos@fisica.ufpr.br>,
       ck@vds.kolivas.org, Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org
References: <20050509112446.GZ1399@nysv.org> <200505111305.48610.kernel@kolivas.org> <20050511072007.GB4718@elte.hu>
In-Reply-To: <20050511072007.GB4718@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2561003.yyaQhTVuV6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505122049.32315.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2561003.yyaQhTVuV6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 11 May 2005 17:20, Ingo Molnar wrote:
> ack on the first patch - but please dont make it a .config option!
> Either it's good enough so that everyone can use it, or it isnt.

Makes a heck of a lot of sense to me. I guess I was just being paranoid /=20
defensive for no good reason. The first patch alone should suffice.

Cheers,
Con

--nextPart2561003.yyaQhTVuV6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCgzS8ZUg7+tp6mRURAmh1AJ42S3uDnexwkXugmnJGgQ9euUFtfACeJaKG
u9DhJZ+sDJUJo2rCyHACzrA=
=S/Cu
-----END PGP SIGNATURE-----

--nextPart2561003.yyaQhTVuV6--
