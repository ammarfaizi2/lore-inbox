Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTJPIta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTJPIt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:49:29 -0400
Received: from mail.actcom.co.il ([192.114.47.15]:56276 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262760AbTJPItO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:49:14 -0400
Date: Thu, 16 Oct 2003 10:44:05 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PCM OSS] via82xx soundcard Oops
Message-ID: <20031016084404.GR5017@actcom.co.il>
References: <20031016083103.GA25472@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqN4RWvJTb9VNux/"
Content-Disposition: inline
In-Reply-To: <20031016083103.GA25472@outpost.ds9a.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqN4RWvJTb9VNux/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2003 at 10:31:03AM +0200, bert hubert wrote:

> Via82xx soundcard, on running wavesurfer
> (http://www.speech.kth.se/wavesurfer/download.html - excellent), I often =
get
> an oops in snd_pcm_format_set_silence, especially with short segments of
> sound:

Fixed in ALSA CVS and in Linus's bitkeeper tree. Will show up in
-test8.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--tqN4RWvJTb9VNux/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jlpUKRs727/VN8sRAoptAJ9MT3bLWHTJpOaVb/IeGGzByJbIEQCgrsNd
0dNayyHa7Nsq1OBFPB/GE+o=
=vB93
-----END PGP SIGNATURE-----

--tqN4RWvJTb9VNux/--
