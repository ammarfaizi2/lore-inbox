Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTJPSnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTJPSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:43:21 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:3244 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263096AbTJPSnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:43:17 -0400
Date: Thu, 16 Oct 2003 20:43:07 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016184306.GZ5017@actcom.co.il>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CSNFvL6ilyiKL/Hs"
Content-Disposition: inline
In-Reply-To: <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CSNFvL6ilyiKL/Hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2003 at 07:28:59PM +0100, John Bradford wrote:

> Surely it's just common sense to say that you have to verify the whole
> block - any algorithm that can compress N values into <N values is
> lossy by definition.  A mathematical proof for that is easy.

N values is easy. N random uncorrelated values is hard.

Pedantic, me?=20
Never.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--CSNFvL6ilyiKL/Hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jua6KRs727/VN8sRAn5/AJ0R448EFfRzy2iKR00LFSecGewTsQCfUSXq
fp51nAkcukWXFiNCRIdZNME=
=0O/g
-----END PGP SIGNATURE-----

--CSNFvL6ilyiKL/Hs--
