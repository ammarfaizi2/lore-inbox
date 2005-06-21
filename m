Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVFUAtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVFUAtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVFUAse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:48:34 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:55521 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261856AbVFUAMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 20:12:35 -0400
From: Mws <mws@twisted-brains.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: it8212 backport for Bartlomiej IDE (Correct diff)
Date: Tue, 21 Jun 2005 02:12:44 +0200
User-Agent: KMail/1.8.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <1119299939.3279.63.camel@localhost.localdomain> <1119304486.3304.67.camel@localhost.localdomain>
In-Reply-To: <1119304486.3304.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4349155.Rh97WVc7B3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506210212.51673.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4349155.Rh97WVc7B3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 June 2005 23:54, Alan Cox wrote:
> On Llu, 2005-06-20 at 21:39, Alan Cox wrote:
> > This lets you throw out the iteraid stuff that has ended up back in due
> > to stupid goings on in the IDE world. Its the same heavily tested code
> > shipped in Fedora/Red Hat products but without the other dependancies on
> > the Bartlomiej IDE layer.
> >=20
> > Pre-requisite: the ide-disk patch I sent to handle pure LBA devices.
hi alan,

applied fine and is working as nice as integrated within your latest ac-set=
s.

thanks for spending the time to seperate this patch.

regards
marcel

--nextPart4349155.Rh97WVc7B3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCt1uDPpA+SyJsko8RAhDsAJ4jJTMPY+YoS+cBNTis8PLfh73JLgCdGQA4
bfcKNGVHqtcvk0TxtMrlpEs=
=Nm9F
-----END PGP SIGNATURE-----

--nextPart4349155.Rh97WVc7B3--
