Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTKNMIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 07:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTKNMIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 07:08:44 -0500
Received: from [161.53.89.100] ([161.53.89.100]:40320 "EHLO www3.purger.com")
	by vger.kernel.org with ESMTP id S262429AbTKNMIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 07:08:42 -0500
Date: Fri, 14 Nov 2003 12:32:24 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Patrick Beard <patrick@scotcomms.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
Message-ID: <20031114113224.GR21265@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Patrick Beard <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test9
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2003 at 09:39:23AM -0000, Patrick Beard wrote:
> I'm having trouble with my smartmedia. Whenever (occasionally it will
> mount - but very rare) I try to mount it I get the following;
> mount: wrong fs type, bad option, bad superblock on /dev/sda,
> or too many mounted file systems
> dmesg shows;
> FAT: Bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev sda

Oh, no, not again... :(

We had the same problem few weeks ago... a patch is in the archives, it
worked for me.

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test9 #1 Sat Oct 25 23:00:37 CEST 2003 i686
 12:31:15 up 8 days, 21:48,  1 user,  load average: 0.29, 0.29, 0.27

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tL1Iq1AzG0/iPGMRAhGyAJ9HlO3pYmp8ZsVsSP1mjkOMPjswJQCeJNw1
T4XqaDSXua6dIFveiUEh0SU=
=SWBE
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
