Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRG3Vi7>; Mon, 30 Jul 2001 17:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268337AbRG3Vij>; Mon, 30 Jul 2001 17:38:39 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:27463 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268326AbRG3ViV>; Mon, 30 Jul 2001 17:38:21 -0400
Date: Mon, 30 Jul 2001 23:36:30 +0200
From: Kurt Garloff <garloff@suse.de>
To: Dan Hollis <goemon@anime.net>
Cc: "James A. Treacy" <treacy@home.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Random (hard) lockups
Message-ID: <20010730233630.G26097@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Dan Hollis <goemon@anime.net>, "James A. Treacy" <treacy@home.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010730222133.D26097@pckurt.casa-etp.nl> <Pine.LNX.4.30.0107301344460.17564-100000@anime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0107301344460.17564-100000@anime.net>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2001 at 01:46:49PM -0700, Dan Hollis wrote:
> Perhaps someone can make a test case .c program which uses K7
> optimizations to smash memory? It would be nice to be able to pin this
> down. Obviously, the standard memory testers aren't catching it.

Well, I posted a test program to LKML, but that one failed to show any
errors. Maybe we have to provoke certain access patterns of (physical)
adresses to trigger the bugs ... ?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZdNexmLh6hyYd04RAsIHAKDL5ZO21Qj+yfW7eqNbNi32Q5XPNACeLfC/
rfjI48jsGWMKqsRBmkLV87Q=
=2TNF
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--
