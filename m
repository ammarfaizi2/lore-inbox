Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWAGWpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWAGWpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWAGWpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:45:04 -0500
Received: from nsm.pl ([62.111.143.37]:55566 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1161037AbWAGWpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:45:02 -0500
Date: Sat, 7 Jan 2006 23:44:56 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Almost 80% of UDP packets dropped
Message-ID: <20060107224455.GD9197@irc.pl>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <f69849430601062303n331ab0aaue8635f69d75d8510@mail.gmail.com> <200601071704.52833.vda@ilport.com.ua> <20060107152325.GC9197@irc.pl> <Pine.LNX.4.61.0601072219480.8085@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601072219480.8085@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2006 at 10:19:56PM +0100, Jan Engelhardt wrote:
>=20
> >> Use TCP instead.
> >
> > Or DCCP.
>=20
> Don't you mean SCTP?

  No, DCCP, UDP-like protocol with TCP-like congestion control. In
mainline kernel since 2.6.14. DCCPv6 in the works.
http://www.wlug.org.nz/DCCP   http://lwn.net/Articles/149756/

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDwERnThhlKowQALQRAg1xAJ99s+C8J8IXKj5oDVeroaF34yxO+ACeOECy
cPGS3O+Z0MJ8sQ8RqTwoO4k=
=H/Jc
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
