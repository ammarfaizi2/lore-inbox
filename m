Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbUAGIu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUAGIu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:50:59 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:48035 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265394AbUAGIu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:50:57 -0500
Date: Wed, 7 Jan 2004 09:50:50 +0100
From: martin f krafft <madduck@madduck.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: problem booting aic7xxx-old with reiserfs
Message-ID: <20040107085050.GA25572@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1aMb6-3Fs-37@gated-at.bofh.it> <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at> <20040106084728.GA3094@piper.madduck.net> <20040106093926.GA5904@piper.madduck.net> <2263062704.1073407695@aslan.scsiguy.com> <20040106195225.GA12262@piper.madduck.net> <3461762704.1073419548@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <3461762704.1073419548@aslan.btc.adaptec.com>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Justin T. Gibbs <gibbs@scsiguy.com> [2004.01.06.2105 +0100]:
> My bad.  The debug level needs to be 0x7f to get the output I need.
> Can you run the test again?

Please find the updated version here:

  ftp://ftp.madduck.net/scratch/dmesg-aix7xxx-debug-0x7f.gz

Thank you!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"if one cannot enjoy reading a book over and over again,
 there is no use in reading it at all."
                                                        -- oscar wilde

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+8hqIgvIgzMMSnURAulNAKDSKTUx/+ahev89rPINnczMULlalQCgofQv
ipsCK5cBZeJIHeIvH1A/jGc=
=0M8O
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
