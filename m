Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVCGEvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVCGEvj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCGEvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:51:38 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:64781 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261619AbVCGEv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:51:28 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.11 breaks ALSA Intel AC97 audio
Date: Mon, 7 Mar 2005 15:51:01 +1100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Lars <lhofhansl@yahoo.com>
References: <422A3C7F.3020501@yahoo.com> <200503071109.08641.michael@ellerman.id.au> <1110157756.29922.0.camel@mindpipe>
In-Reply-To: <1110157756.29922.0.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1783252.XxF6h7Orfm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503071551.20365.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1783252.XxF6h7Orfm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Lee, that fixed it.

On Mon, 7 Mar 2005 12:09, Lee Revell wrote:
> On Mon, 2005-03-07 at 11:09 +1100, Michael Ellerman wrote:
> > Hi Lars,
> >
> > Yeah I've got no audio on my T41, which I think uses the AC97 too. I
> > haven't had time to look into it though :/
>
> Did you disable "Headphone Jack Sense" and "Line Jack Sense" in
> alsamixer?
>
> Lee


--nextPart1783252.XxF6h7Orfm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCK93IdSjSd0sB4dIRAszZAJ9ytaAUjOpLlzU2W+F2J50D3Kj11wCglyzt
ue9Q32YdC8r8bTmUlyAzSk8=
=azhZ
-----END PGP SIGNATURE-----

--nextPart1783252.XxF6h7Orfm--
