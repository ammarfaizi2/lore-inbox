Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTFYMfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFYMfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:35:44 -0400
Received: from komoseva.globalnet.hr ([213.149.32.250]:25611 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S264054AbTFYMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:35:43 -0400
Date: Wed, 25 Jun 2003 13:50:13 +0200
From: Vid Strpic <vms@bofhlet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: contents of a cd-rom disappearing and re-appearing! 2.4.21
Message-ID: <20030625115013.GE20998@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled May  3 2002 20:49:56)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2003 at 10:46:31PM +0200, Folkert van Heusden wrote:
> I had this really strange experience with a cd-rom.
> I was in it's mountpoint, did ls, all fine.
> Did nothing for a while, then did ls again: everything gone!
> I then cd'd to home and back to the mountpoint and ls: everything's
> back.
> I never had this while running 2.4.20.

Hm.  Looks like some automounter, or more precisely, autounmounter :)
Which distribution?  I had no such problems with .21, yet...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux lorien 2.4.21 #1 Sat Jun 14 01:23:07 CEST 2003 i586
 13:48:52 up 11 days, 10:30,  8 users,  load average: 0.47, 0.23, 0.26
Every cat deserves a house, but not every house deserves a cat

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE++Yx1q1AzG0/iPGMRAhZUAKCA7GXAENpoVby/MghxlWOO3T+a/QCg1j5p
YnjUVVJEXpf/njh+85LB8UQ=
=QOZl
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
