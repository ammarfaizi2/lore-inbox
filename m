Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTGMCB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270069AbTGMCB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 22:01:57 -0400
Received: from main.gmane.org ([80.91.224.249]:9912 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270066AbTGMCB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 22:01:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
 enhancements
Date: Sat, 12 Jul 2003 19:17:24 -0700
Message-ID: <m2vfu7cgqz.fsf@tnuctip.rychter.com>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz>
 <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz>
 <1058038701.2482.25.camel@laptop-linux> <20030712201525.GB446@elf.ucw.cz>
 <1058041325.2007.4.camel@laptop-linux> <20030712225258.GB1508@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:8V1zV/20jWmA5N2TedVWhndFGdQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Pavel" =3D=3D Pavel Machek <pavel@suse.cz> writes:
 Pavel> Hi!
 > No, you don't understand.
 >
 > Magic SysRq is well known mechanism for torturing running
 > kernel. Kernel hackers have it enabled, security-consious people have
 > it disabled, and it is /proc-tweakable. It also works in cases like
 > "the only keyboard on serial terminal", etc.
 >>
 >> Ah okay. So the security by obscurity bit was wrong, but the general
 >> idea of SysRq-Esc was right?

 Pavel> I guess so. Advantage is that people already know about Magic
 Pavel> Sysrq and know how to disable it. (It would be something like
 Pavel> Sysrq-E, you can't really use esc).  Pavel

This discussion is strange. Nigel is right, if one starts suspending by
mistake, one wants to be able to abort it easily. 'Esc' is just the
perfect key for that. What's the point of hiding or obscuring it? I
mean, why would you want to do that? You don't routinely 'hide' Ctrl-C
for security reasons, do you?

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EME5Lth4/7/QhDoRAgy+AJ4mNKdyjZk4VvDObQJYO/+YIXFxSQCfZlWf
7C48wvu9Z1BmpGXk0G6ClU0=
=dGVf
-----END PGP SIGNATURE-----
--=-=-=--

