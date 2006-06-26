Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933330AbWFZWxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330AbWFZWxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933377AbWFZWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:53:19 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:2479 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S933315AbWFZWw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:52:56 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 0/2] Cryptoapi deflate fix.
Date: Tue, 27 Jun 2006 08:52:50 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626165135.10864.53686.stgit@nigel.suspend2.net> <200606262209.50749.rjw@sisk.pl>
In-Reply-To: <200606262209.50749.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1480856.knqOOEylyO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606270852.54153.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1480856.knqOOEylyO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 06:09, Rafael J. Wysocki wrote:
> On Monday 26 June 2006 18:51, Nigel Cunningham wrote:
> > The deflate module doesn't properly complete the handling of PAGE_SIZE
> > chunks of data. This patch corrects that so that it can be used with
> > Suspend2.
>
> Well, it also adds the LZF support to the cryptoapi.  These are two
> different things.
>
> If you think the deflate modules needs to be fixed, you should post the
> patch for it separately, I think.
>
> Rafael

Sorry for the bad choice of heading. I have posted this before and emailed =
it=20
direct to Herbert, but he (rightly) doesn't see the need while suspend2 isn=
't=20
merged.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1480856.knqOOEylyO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoGVGN0y+n1M3mo0RAnTzAKC8TVuesZT2Ws0QtsrgLwZ1TY3IIgCfVsPA
cZsJlFCD2vImvT+XntZfcSA=
=oDfs
-----END PGP SIGNATURE-----

--nextPart1480856.knqOOEylyO--
