Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265958AbRFZJLb>; Tue, 26 Jun 2001 05:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265959AbRFZJLM>; Tue, 26 Jun 2001 05:11:12 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:22543 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S265958AbRFZJLI>;
	Tue, 26 Jun 2001 05:11:08 -0400
Date: Tue, 26 Jun 2001 13:10:31 +0400
To: David Grant <davidgrant79@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Message-ID: <20010626131031.A24248@orbita1.ru>
In-Reply-To: <3BDF3E4668AD0D49A7B0E3003B294282BC96@etmain.edafio.com> <OE52GD1XyCTr9rf3yXv00004cfb@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
User-Agent: Mutt/1.0.1i
In-Reply-To: <OE52GD1XyCTr9rf3yXv00004cfb@hotmail.com>; from davidgrant79@hotmail.com on Mon, Jun 25, 2001 at 01:27:56PM -0700
X-Uptime: 12:33pm  up 26 days, 20:16,  3 users,  load average: 0.01, 0.01, 0.00
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2001 at 01:27:56PM -0700, David Grant wrote:

> I'd be interested in testing any fixes for the VIA Southbridge chip.  I h=
ave
> an ASUS A7V133.  I was having problems with the IDE controller, but I've
> switched to the on-board Promise IDE and it works fine.  I couldn't get r=
id
> of the DMA timeout errors with my VIA vt82c686b, even with the latest
> patches.  I even completely disabled DMA (through .config options) and I
> although I didn't get DMA timeout errors anymore, everything still came t=
o a
> halt under heavy disk usage.
>=20
> Would it be a good idea to form a small mailing list of people with VIA
> chipsets (vt82c686b only)?  Then perhaps we could communicate with Vojtech
> more easily, and the VIA southbridge problems might end a little quicker.
> It seems like there are a bunch of people still having the VIA problems.

linux-via@gtf.org

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7OFGHBm4rlNOo3YgRAoPXAJ9VPR0uxGf+TFI7OIHB3J6L+N6v4wCdESXe
88i6dXM6D/kUquc1ADY78l4=
=aBfv
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
