Return-Path: <linux-kernel-owner+w=401wt.eu-S1762952AbWLKRaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762952AbWLKRaO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762984AbWLKRaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:30:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:43076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762952AbWLKRaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:30:12 -0500
X-Authenticated: #815327
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Window scaling problem?
Date: Mon, 11 Dec 2006 18:29:44 +0100
User-Agent: KMail/1.9.5
Cc: Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr> <m33b7mhjfh.fsf@ursa.amorsen.dk> <Pine.LNX.4.61.0612111102230.11941@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612111102230.11941@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2923085.vF2KolQiPJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612111829.49469.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2923085.vF2KolQiPJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 December 2006 11:03, Jan Engelhardt wrote:
> Is there some test utility I can run that reliably says if there is a
> broken window scaler in the path to an arbitrary host?

Isn't window scaling something that the tcp-stacks on both ends of the=20
connection do? AFAIK the routers and firewalls that push the packets around=
=20
have nothing to do with it .. but I could be wrong ;)

BTW. I am seeing similar things when I go through a CheckPoint VPN-1 firewa=
ll.

Regards
=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart2923085.vF2KolQiPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFfZWN4q3E2oMjYtURAkZxAKDT+oVhCNefiahLp9YPze/jVdDMMgCeKmib
Nl1VID1lpJCSQX9KTyxxHYI=
=Uu5U
-----END PGP SIGNATURE-----

--nextPart2923085.vF2KolQiPJ--
