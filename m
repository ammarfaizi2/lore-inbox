Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270399AbTGMVFn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270402AbTGMVFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:05:43 -0400
Received: from screech.rychter.com ([212.87.11.114]:49330 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S270399AbTGMVFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:05:42 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
 enhancements
References: <1057963547.3207.22.camel@laptop-linux>
	<20030712140057.GC284@elf.ucw.cz>
	<200307121734.29941.dtor_core@ameritech.net>
	<20030712225143.GA1508@elf.ucw.cz>
	<20030713133517.GD19132@mail.jlokier.co.uk>
	<20030713193114.GD570@elf.ucw.cz>
	<1058130071.1829.2.camel@laptop-linux>
	<20030713210934.GK570@elf.ucw.cz>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Sun, 13 Jul 2003 14:21:10 -0700
In-Reply-To: <20030713210934.GK570@elf.ucw.cz> (Pavel Machek's message of
 "Sun, 13 Jul 2003 23:09:34 +0200")
Message-ID: <m265m615tl.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Pavel" =3D=3D Pavel Machek <pavel@suse.cz> writes:
 Pavel> Hi!
 >> Escape is more intuitively obvious though - I would expect the
 >> suspend button to only start a suspend. And the idea of escape
 >> cancelling anything is well in-grained in peoples' minds.

 Pavel> You did not initiate suspend from keyboard =3D> you should not
 Pavel> terminate it from keyboard.

Oh, come on. I usually initiate suspend by doing 'sh suspend' as root.

Besides, implementing swsusp support for ACPI events is IMHO right next
to impossible (not to mention unbelievably messy), and that's what you'd
need to have your power button abort the suspend process.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Ec1HLth4/7/QhDoRAoLWAJ4usmonwsMpiYdEGlVYEXMONS7EOwCgviE1
SJux/MV7SX0a+Urf4/nn5Ds=
=o5WW
-----END PGP SIGNATURE-----
--=-=-=--
